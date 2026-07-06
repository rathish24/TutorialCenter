import 'package:tutorial_management/data/datasources/teacher_firebase_datasource.dart';
import 'package:tutorial_management/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/models/teacher.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherFirebaseDatasource remoteDatasource;
  final TeacherLocalDatasource localDatasource;

  TeacherRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<Teacher>> getCachedTeachers() {
    return localDatasource.getCachedTeachers();
  }

  @override
  Future<List<Teacher>> getTeachers() async {
    final teachers = await remoteDatasource.getTeachers();
    await localDatasource.cacheTeachers(teachers);
    return teachers;
  }

  @override
  Future<void> addTeacher(Teacher teacher) async {
    await remoteDatasource.addTeacher(teacher);
    await localDatasource.cacheSingleTeacher(teacher);
  }
}
