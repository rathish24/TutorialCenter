import 'package:equatable/equatable.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object?> get props => [];
}

class TeacherInitialState extends TeacherState {
  const TeacherInitialState();
}

class TeacherLoadingState extends TeacherState {
  const TeacherLoadingState();
}

class TeacherLoadedState extends TeacherState {
  final List<Teacher> teachers;

  const TeacherLoadedState(this.teachers);

  @override
  List<Object?> get props => [teachers];
}

class TeacherErrorState extends TeacherState {
  final String message;

  const TeacherErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
