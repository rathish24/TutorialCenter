import 'package:tutorial_management/features/teacher/data/datasources/teacher_remote_datasource.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';
import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherRemoteDatasource remoteDatasource;
  final TeacherLocalDatasource localDatasource;

  TeacherRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<Teacher>> getCachedTeachers() async {
    final models = await localDatasource.getCachedTeachers();
    return models.map((model) => model as Teacher).toList();
  }

  @override
  Future<List<Teacher>> getTeachers() async {
    final models = await remoteDatasource.getTeachers();
    await localDatasource.cacheTeachers(models);
    return models.map((model) => model as Teacher).toList();
  }

  @override
  Future<void> addTeacher(Teacher teacher) async {
    final model = TeacherModel.fromEntity(teacher);
    await remoteDatasource.addTeacher(model);
    await localDatasource.cacheSingleTeacher(model);
  }
}
