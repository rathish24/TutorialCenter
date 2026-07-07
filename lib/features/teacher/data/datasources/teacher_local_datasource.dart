import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

abstract class TeacherLocalDatasource {
  Future<List<TeacherModel>> getCachedTeachers();
  Future<void> cacheTeachers(List<TeacherModel> teachers);
  Future<void> cacheSingleTeacher(TeacherModel teacher);
}
