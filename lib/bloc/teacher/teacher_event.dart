import 'package:equatable/equatable.dart';
import 'package:tutorial_management/models/teacher.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeachersEvent extends TeacherEvent {
  const LoadTeachersEvent();
}

class AddTeacherEvent extends TeacherEvent {
  final Teacher teacher;

  const AddTeacherEvent(this.teacher);

  @override
  List<Object?> get props => [teacher];
}
