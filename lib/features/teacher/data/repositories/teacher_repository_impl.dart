import 'package:tutorial_management/core/errors/failures.dart';
import 'package:tutorial_management/core/errors/result.dart';
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
  Future<Result<List<Teacher>, Failure>> getCachedTeachers() async {
    try {
      final models = await localDatasource.getCachedTeachers();
      final teachers = models.map((model) => model as Teacher).toList();
      return Success(teachers);
    } catch (e) {
      return ErrorResult(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Teacher>, Failure>> getTeachers() async {
    try {
      final models = await remoteDatasource.getTeachers();
      await localDatasource.cacheTeachers(models);
      final teachers = models.map((model) => model as Teacher).toList();
      return Success(teachers);
    } catch (e) {
      return ErrorResult(ExceptionMapper.mapToFailure(e));
    }
  }

  @override
  Future<Result<void, Failure>> addTeacher(Teacher teacher) async {
    try {
      final model = TeacherModel.fromEntity(teacher);
      await remoteDatasource.addTeacher(model);
      await localDatasource.cacheSingleTeacher(model);
      return const Success(null);
    } catch (e) {
      return ErrorResult(ExceptionMapper.mapToFailure(e));
    }
  }
}
