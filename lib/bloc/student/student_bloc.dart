import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/student/student_event.dart';
import 'package:tutorial_management/bloc/student/student_state.dart';
import 'package:tutorial_management/models/student.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(const StudentInitialState()) {
    on<LoadStudentsEvent>(_onLoadStudents);
    on<AddStudentEvent>(_onAddStudents);
  }

  void _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(const StudentLoadingState());

    await Future.delayed(const Duration(milliseconds: 800));
    final initialStudents = [
      Student(
        id: 1,
        name: "Liam Carter",
        profileURL: "https://i.pravatar.cc/150?img=12",
        age: 20,
        gender: "Male",
        contactNumber: "555-019-2834",
      ),
      Student(
        id: 2,
        name: "Sophia Martinez",
        profileURL: "https://i.pravatar.cc/150?img=49",
        age: 19,
        gender: "Female",
        contactNumber: "555-014-8392",
      ),
      Student(
        id: 3,
        name: "Ethan Thompson",
        profileURL: "https://i.pravatar.cc/150?img=33",
        age: 21,
        gender: "Male",
        contactNumber: "555-017-4829",
      ),
      Student(
        id: 4,
        name: "Olivia Chen",
        profileURL: "https://i.pravatar.cc/150?img=26",
        age: 18,
        gender: "Female",
        contactNumber: "555-015-7283",
      ),
      Student(
        id: 5,
        name: "Noah Jackson",
        profileURL: "https://i.pravatar.cc/150?img=11",
        age: 22,
        gender: "Male",
        contactNumber: "555-012-9384",
      ),
      Student(
        id: 6,
        name: "Emma Watson",
        profileURL: "https://i.pravatar.cc/150?img=47",
        age: 20,
        gender: "Female",
        contactNumber: "555-011-8273",
      ),
    ];

    emit(StudentLoadedState(initialStudents));
  }

  void _onAddStudents(AddStudentEvent event, Emitter<StudentState> emit) async {
    if (state is StudentLoadedState) {
      final currentStudents = (state as StudentLoadedState).students;
      emit(StudentLoadedState([...currentStudents, event.student]));
    }
  }
}
