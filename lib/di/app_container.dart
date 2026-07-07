import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorial_management/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/data/datasources/hive_teacher_datasource.dart';
import 'package:tutorial_management/data/repositories/teacher_repository_impl.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_cached_teachers_usecase.dart';

class AppContainer {
  final Box? teachersBox;
  final FirebaseFirestore? firestore;
  final TeacherFirebaseDatasource? remoteDatasource;
  final TeacherLocalDatasource? localDatasource;
  final TeacherRepository? teacherRepository;
  
  final GetTeachersUseCase getTeachersUseCase;
  final GetCachedTeachersUseCase getCachedTeachersUseCase;
  final AddTeacherUseCase addTeacherUseCase;

  AppContainer({
    this.teachersBox,
    this.firestore,
    this.remoteDatasource,
    this.localDatasource,
    this.teacherRepository,
    required this.getTeachersUseCase,
    required this.getCachedTeachersUseCase,
    required this.addTeacherUseCase,
  });

  static Future<AppContainer> initialize() async {
    await Firebase.initializeApp();
    await Hive.initFlutter();

    final box = await Hive.openBox('teachers_box');
    final firestoreInstance = FirebaseFirestore.instance;

    final remote = TeacherFirebaseDatasource(firestore: firestoreInstance);
    final local = HiveTeacherDatasource(box: box);

    final repository = TeacherRepositoryImpl(
      remoteDatasource: remote,
      localDatasource: local,
    );

    final getTeachers = GetTeachersUseCase(repository);
    final getCachedTeachers = GetCachedTeachersUseCase(repository);
    final addTeacher = AddTeacherUseCase(repository);

    return AppContainer(
      teachersBox: box,
      firestore: firestoreInstance,
      remoteDatasource: remote,
      localDatasource: local,
      teacherRepository: repository,
      getTeachersUseCase: getTeachers,
      getCachedTeachersUseCase: getCachedTeachers,
      addTeacherUseCase: addTeacher,
    );
  }
}
