import 'package:tutorial_management/models/teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachers();
  Future<List<Teacher>> getCachedTeachers();
  Future<void> addTeacher(Teacher teacher);
}
