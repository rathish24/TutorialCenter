import 'package:equatable/equatable.dart';
import 'package:tutorial_management/features/student/domain/entities/student.dart';

sealed class StudentState extends Equatable {
  const StudentState();
  @override
  List<Object> get props => [];
}

class StudentInitialState extends StudentState {
  const StudentInitialState();
}

class StudentLoadingState extends StudentState {
  const StudentLoadingState();
}

class StudentLoadedState extends StudentState {
  final List<Student> students;

  const StudentLoadedState(this.students);

  @override
  List<Object> get props => [students];
}

class StudentErrorState extends StudentState {
  final String message;

  const StudentErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class StudentAddedState extends StudentState {
  final Student student;

  const StudentAddedState(this.student);

  @override
  List<Object> get props => [student];
}
