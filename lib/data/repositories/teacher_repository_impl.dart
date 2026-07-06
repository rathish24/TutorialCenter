import 'package:tutorial_management/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/models/teacher.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherFirebaseDatasource remoteDatasource;

  TeacherRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Teacher>> getTeachers() {
    return remoteDatasource.getTeachers();
  }

  @override
  Future<void> addTeacher(Teacher teacher) {
    return remoteDatasource.addTeacher(teacher);
  }
}
