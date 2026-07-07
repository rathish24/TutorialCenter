import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorial_management/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/data/datasources/hive_teacher_datasource.dart';
import 'package:tutorial_management/data/repositories/teacher_repository_impl.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/navigation/app_navigator.dart';
import 'package:tutorial_management/navigation/app_router.dart';

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

  // Register datasources
  sl.registerLazySingleton<TeacherFirebaseDatasource>(
    () => TeacherFirebaseDatasource(firestore: sl()),
  );
  sl.registerLazySingleton<TeacherLocalDatasource>(
    () => HiveTeacherDatasource(box: sl()),
  );

  // Register repositories
  sl.registerLazySingleton<TeacherRepository>(
    () => TeacherRepositoryImpl(
      remoteDatasource: sl<TeacherFirebaseDatasource>(),
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
