import 'package:tutorial_management/core/errors/failures.dart';
import 'package:tutorial_management/core/errors/result.dart';
import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

class GetTeachersUseCase {
  final TeacherRepository repository;

  GetTeachersUseCase(this.repository);

  Future<Result<List<Teacher>, Failure>> call() {
    return repository.getTeachers();
  }
}
