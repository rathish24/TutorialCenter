import 'package:tutorial_management/models/teacher.dart';

abstract class TeacherRemoteDatasource {
  Future<List<Teacher>> getTeachers();
  Future<void> addTeacher(Teacher teacher);
}
