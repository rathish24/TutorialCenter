import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/models/teacher.dart';

class GetTeachersUseCase {
  final TeacherRepository repository;

  GetTeachersUseCase(this.repository);

  Future<List<Teacher>> call() {
    return repository.getTeachers();
  }
}
