import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/models/teacher.dart';

class AddTeacherUseCase {
  final TeacherRepository repository;

  AddTeacherUseCase(this.repository);

  Future<void> call(Teacher teacher) {
    return repository.addTeacher(teacher);
  }
}
