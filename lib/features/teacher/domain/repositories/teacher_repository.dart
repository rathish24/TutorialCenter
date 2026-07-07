import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachers();
  Future<List<Teacher>> getCachedTeachers();
  Future<void> addTeacher(Teacher teacher);
}
