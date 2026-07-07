import 'package:tutorial_management/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

class GetCachedTeachersUseCase {
  final TeacherRepository repository;

  GetCachedTeachersUseCase(this.repository);

  Future<List<Teacher>> call() {
    return repository.getCachedTeachers();
  }
}
