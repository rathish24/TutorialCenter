import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorial_management/core/cache/hive_client.dart';
import 'package:tutorial_management/core/cache/local_database_client.dart';
import 'package:tutorial_management/core/network/api_client.dart';
import 'package:tutorial_management/core/network/graphql_client.dart';
import 'package:tutorial_management/core/network/connectivity_service.dart';
import 'package:tutorial_management/core/network/interceptors/auth_interceptor.dart';
import 'package:tutorial_management/core/network/interceptors/connectivity_interceptor.dart';
import 'package:tutorial_management/core/network/interceptors/logging_interceptor.dart';
import 'package:tutorial_management/core/network/interceptors/retry_interceptor.dart';
import 'package:tutorial_management/core/network/token_refresher.dart';
import 'package:tutorial_management/core/network/token_storage.dart';
import 'package:tutorial_management/core/firebase/firebase_logger.dart';
import 'package:tutorial_management/core/firebase/firestore_client.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_remote_datasource.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/features/teacher/data/datasources/hive_teacher_datasource.dart';
import 'package:tutorial_management/features/teacher/data/repositories/teacher_repository_impl.dart';
import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/core/navigation/app_navigator.dart';
import 'package:tutorial_management/core/navigation/app_router.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize services
  await Firebase.initializeApp();
  await Hive.initFlutter();

  // Register external dependencies / drivers
  final box = await Hive.openBox('teachers_box');
  sl.registerSingleton<Box>(box);

  final firestoreInstance = FirebaseFirestore.instance;
  sl.registerSingleton<FirebaseFirestore>(firestoreInstance);

  // Register Connectivity Service
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityServiceImpl(sl()));

  // Register Token Management
  sl.registerLazySingleton<TokenStorage>(() => InMemoryTokenStorage());
  sl.registerLazySingleton<TokenRefresher>(() => MockTokenRefresher());

  // Register Dio clients
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    );

    final refreshDio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.addAll([
      ConnectivityInterceptor(sl()),
      AuthInterceptor(
        tokenStorage: sl(),
        tokenRefresher: sl(),
        refreshDio: refreshDio,
      ),
      RetryInterceptor(dio: dio),
      LoggingInterceptor(isDebug: kDebugMode),
    ]);

    return dio;
  });

  // Register API Client
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));
  sl.registerLazySingleton<GraphQLClientWrapper>(() => GraphQLClientWrapperImpl(sl()));

  // Register Firebase Wrappers
  sl.registerLazySingleton<FirebaseLogger>(() => FirebaseLogger(isDebug: kDebugMode));
  sl.registerLazySingleton<FirestoreClient>(() => FirestoreClient(sl(), sl()));
  sl.registerLazySingleton<LocalDatabaseClient>(() => HiveClient(sl<Box>()));

  // Register datasources
  sl.registerLazySingleton<TeacherRemoteDatasource>(
    () => TeacherFirebaseDatasource(firestoreClient: sl()),
  );
  sl.registerLazySingleton<TeacherLocalDatasource>(
    () => HiveTeacherDatasource(localDatabaseClient: sl()),
  );

  // Register repositories
  sl.registerLazySingleton<TeacherRepository>(
    () => TeacherRepositoryImpl(
      remoteDatasource: sl<TeacherRemoteDatasource>(),
      localDatasource: sl<TeacherLocalDatasource>(),
    ),
  );

  // Register use cases
  sl.registerLazySingleton(() => GetTeachersUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedTeachersUseCase(sl()));
  sl.registerLazySingleton(() => AddTeacherUseCase(sl()));

  // Register routing & navigation
  final appRouter = AppRouter();
  sl.registerSingleton<AppRouter>(appRouter);
  sl.registerSingleton<AppNavigator>(AppNavigatorImpl(appRouter));
}
