import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

abstract class TeacherRemoteDatasource {
  Future<List<TeacherModel>> getTeachers();
  Future<void> addTeacher(TeacherModel teacher);
}
