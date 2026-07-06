import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/models/teacher.dart';

class GetCachedTeachersUseCase {
  final TeacherRepository repository;

  GetCachedTeachersUseCase(this.repository);

  Future<List<Teacher>> call() {
    return repository.getCachedTeachers();
  }
}
