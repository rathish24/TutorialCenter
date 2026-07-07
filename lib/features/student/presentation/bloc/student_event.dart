import 'dart:developer' as developer;
import 'package:equatable/equatable.dart';
import 'package:tutorial_management/features/student/domain/entities/student.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentsEvent extends StudentEvent {
  LoadStudentsEvent() {
    developer.log('LoadStudentEvent initialized', name: 'StudentEvent');
  }
}

class AddStudentEvent extends StudentEvent {
  final Student student;

  AddStudentEvent(this.student) {
    developer.log(
      'AddStudentEvent initialized: student = ${student.name}',
      name: 'StudentEvent',
    );
  }

  @override
  List<Object?> get props => [student];
}
