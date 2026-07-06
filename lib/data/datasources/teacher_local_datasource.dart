import 'package:tutorial_management/models/teacher.dart';

abstract class TeacherLocalDatasource {
  Future<List<Teacher>> getCachedTeachers();
  Future<void> cacheTeachers(List<Teacher> teachers);
  Future<void> cacheSingleTeacher(Teacher teacher);
}
