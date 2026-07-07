import 'package:tutorial_management/core/errors/failures.dart';
import 'package:tutorial_management/core/errors/result.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

abstract class TeacherRepository {
  Future<Result<List<Teacher>, Failure>> getTeachers();
  Future<Result<List<Teacher>, Failure>> getCachedTeachers();
  Future<Result<void, Failure>> addTeacher(Teacher teacher);
}
