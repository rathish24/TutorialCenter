import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/student/student_bloc.dart';
import 'package:tutorial_management/bloc/student/student_event.dart';
import 'package:tutorial_management/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/data/repositories/teacher_repository_impl.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/models/teacher.dart';
import 'package:tutorial_management/ui/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final remoteDatasource = TeacherFirebaseDatasource(firestore: firestore);
  final repository = TeacherRepositoryImpl(remoteDatasource: remoteDatasource);
  final getTeachersUseCase = GetTeachersUseCase(repository);
  final addTeacherUseCase = AddTeacherUseCase(repository);

  runApp(
    MyApp(
      getTeachersUseCase: getTeachersUseCase,
      addTeacherUseCase: addTeacherUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetTeachersUseCase getTeachersUseCase;
  final AddTeacherUseCase addTeacherUseCase;

  const MyApp({
    super.key,
    required this.getTeachersUseCase,
    required this.addTeacherUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeacherBloc>(
          create: (context) => TeacherBloc(
            getTeachersUseCase: getTeachersUseCase,
            addTeacherUseCase: addTeacherUseCase,
          )..add(const LoadTeachersEvent()),
        ),
        BlocProvider<StudentBloc>(
          create: (context) => StudentBloc()..add(LoadStudentsEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

// Fake repository and use cases for Widget Preview compatibility
class _FakeTeacherRepository implements TeacherRepository {
  @override
  Future<List<Teacher>> getTeachers() async => [];
  @override
  Future<void> addTeacher(Teacher teacher) async {}
}

@Preview(name: 'Home')
Widget myAppPreview() {
  final fakeRepo = _FakeTeacherRepository();
  return MyApp(
    getTeachersUseCase: GetTeachersUseCase(fakeRepo),
    addTeacherUseCase: AddTeacherUseCase(fakeRepo),
  );
}
