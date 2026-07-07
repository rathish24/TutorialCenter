import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/student/student_bloc.dart';
import 'package:tutorial_management/bloc/student/student_event.dart';
import 'package:tutorial_management/di/app_container.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/models/teacher.dart';
import 'package:tutorial_management/navigation/app_navigator.dart';
import 'package:tutorial_management/navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await AppContainer.initialize();

  runApp(MyApp(container: container));
}

class MyApp extends StatelessWidget {
  final AppContainer container;

  const MyApp({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppNavigator>.value(
      value: container.appNavigator,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TeacherBloc>(
            create: (context) => TeacherBloc(
              getTeachersUseCase: container.getTeachersUseCase,
              getCachedTeachersUseCase: container.getCachedTeachersUseCase,
              addTeacherUseCase: container.addTeacherUseCase,
            )..add(const LoadTeachersEvent()),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc()..add(LoadStudentsEvent()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: container.appRouter.router,
        ),
      ),
    );
  }
}

// Fake repository and use cases for Widget Preview compatibility
class _FakeTeacherRepository implements TeacherRepository {
  @override
  Future<List<Teacher>> getTeachers() async => [];
  @override
  Future<List<Teacher>> getCachedTeachers() async => [];
  @override
  Future<void> addTeacher(Teacher teacher) async {}
}

@Preview(name: 'Home')
Widget myAppPreview() {
  final fakeRepo = _FakeTeacherRepository();
  final fakeRouter = AppRouter();
  final fakeNavigator = AppNavigatorImpl(fakeRouter);
  final fakeContainer = AppContainer(
    getTeachersUseCase: GetTeachersUseCase(fakeRepo),
    getCachedTeachersUseCase: GetCachedTeachersUseCase(fakeRepo),
    addTeacherUseCase: AddTeacherUseCase(fakeRepo),
    appRouter: fakeRouter,
    appNavigator: fakeNavigator,
  );
  return MyApp(container: fakeContainer);
}
