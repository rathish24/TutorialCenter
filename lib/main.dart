import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_event.dart';
import 'package:tutorial_management/features/student/presentation/bloc/student_bloc.dart';
import 'package:tutorial_management/features/student/presentation/bloc/student_event.dart';
import 'package:tutorial_management/core/di/app_container.dart';
import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';
import 'package:tutorial_management/core/navigation/app_navigator.dart';
import 'package:tutorial_management/core/navigation/app_router.dart';
import 'package:tutorial_management/core/theme/app_theme.dart';
import 'package:tutorial_management/core/errors/failures.dart';
import 'package:tutorial_management/core/errors/result.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppNavigator>.value(
      value: sl<AppNavigator>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TeacherBloc>(
            create: (context) => TeacherBloc(
              getTeachersUseCase: sl<GetTeachersUseCase>(),
              getCachedTeachersUseCase: sl<GetCachedTeachersUseCase>(),
              addTeacherUseCase: sl<AddTeacherUseCase>(),
            )..add(const LoadTeachersEvent()),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc()..add(LoadStudentsEvent()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: sl<AppRouter>().router,
        ),
      ),
    );
  }
}

// Fake repository and use cases for Widget Preview compatibility
class _FakeTeacherRepository implements TeacherRepository {
  @override
  Future<Result<List<Teacher>, Failure>> getTeachers() async => const Success([]);
  @override
  Future<Result<List<Teacher>, Failure>> getCachedTeachers() async => const Success([]);
  @override
  Future<Result<void, Failure>> addTeacher(Teacher teacher) async => const Success(null);
}

@Preview(name: 'Home')
Widget myAppPreview() {
  final fakeRepo = _FakeTeacherRepository();
  final fakeRouter = AppRouter();
  final fakeNavigator = AppNavigatorImpl(fakeRouter);

  if (sl.isRegistered<AppNavigator>()) {
    sl.pushNewScope(init: (sl) {
      sl.registerSingleton<GetTeachersUseCase>(GetTeachersUseCase(fakeRepo));
      sl.registerSingleton<GetCachedTeachersUseCase>(GetCachedTeachersUseCase(fakeRepo));
      sl.registerSingleton<AddTeacherUseCase>(AddTeacherUseCase(fakeRepo));
      sl.registerSingleton<AppRouter>(fakeRouter);
      sl.registerSingleton<AppNavigator>(fakeNavigator);
    });
  } else {
    sl.registerSingleton<GetTeachersUseCase>(GetTeachersUseCase(fakeRepo));
    sl.registerSingleton<GetCachedTeachersUseCase>(GetCachedTeachersUseCase(fakeRepo));
    sl.registerSingleton<AddTeacherUseCase>(AddTeacherUseCase(fakeRepo));
    sl.registerSingleton<AppRouter>(fakeRouter);
    sl.registerSingleton<AppNavigator>(fakeNavigator);
  }

  return const MyApp();
}
