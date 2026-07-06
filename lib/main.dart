import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/student/student_bloc.dart';
import 'package:tutorial_management/bloc/student/student_event.dart';
import 'package:tutorial_management/ui/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeacherBloc>(
          create: (context) => TeacherBloc()..add(const LoadTeachersEvent()),
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

@Preview(name: 'Home')
Widget myAppPreview() {
  return const MyApp();
}
