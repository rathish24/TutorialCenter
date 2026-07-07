import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

class GetTeachersUseCase {
  final TeacherRepository repository;

  GetTeachersUseCase(this.repository);

  Future<List<Teacher>> call() {
    return repository.getTeachers();
  }
}
