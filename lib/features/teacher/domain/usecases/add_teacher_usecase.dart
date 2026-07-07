import 'package:tutorial_management/core/errors/failures.dart';
import 'package:tutorial_management/core/errors/result.dart';
import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

class AddTeacherUseCase {
  final TeacherRepository repository;

  AddTeacherUseCase(this.repository);

  Future<Result<void, Failure>> call(Teacher teacher) {
    return repository.addTeacher(teacher);
  }
}
