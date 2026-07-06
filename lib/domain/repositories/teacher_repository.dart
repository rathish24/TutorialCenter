import 'package:tutorial_management/models/teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachers();
  Future<void> addTeacher(Teacher teacher);
}
