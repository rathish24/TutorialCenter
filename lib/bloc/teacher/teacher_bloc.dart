import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/models/teacher.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(const TeacherInitialState()) {
    on<LoadTeachersEvent>(_onLoadTeachers);
    on<AddTeacherEvent>(_onAddTeacher);
  }

  void _onLoadTeachers(LoadTeachersEvent event, Emitter<TeacherState> emit) {
    emit(const TeacherLoadingState());
    
    // Default initial mock data
    final initialTeachers = [
      Teacher(
        id: 1,
        name: "Dr. Sarah Jenkins",
        profileURL: "https://i.pravatar.cc/150?img=47",
        age: 34,
        gender: "Female",
        contactNumber: "123-456-7890",
      ),
      Teacher(
        id: 2,
        name: "Prof. James Wilson",
        profileURL: "https://i.pravatar.cc/150?img=33",
        age: 42,
        gender: "Male",
        contactNumber: "987-654-3210",
      ),
      Teacher(
        id: 3,
        name: "Ms. Emily Davis",
        profileURL: "https://i.pravatar.cc/150?img=49",
        age: 29,
        gender: "Female",
        contactNumber: "555-123-4567",
      ),
      Teacher(
        id: 4,
        name: "Mr. Michael Chen",
        profileURL: "https://i.pravatar.cc/150?img=12",
        age: 38,
        gender: "Male",
        contactNumber: "444-987-6543",
      ),
      Teacher(
        id: 5,
        name: "Dr. Elena Rostova",
        profileURL: "https://i.pravatar.cc/150?img=26",
        age: 31,
        gender: "Female",
        contactNumber: "333-444-5555",
      ),
      Teacher(
        id: 6,
        name: "Prof. Marcus Aurelius",
        profileURL: "https://i.pravatar.cc/150?img=11",
        age: 48,
        gender: "Male",
        contactNumber: "222-111-0000",
      ),
    ];

    emit(TeacherLoadedState(initialTeachers));
  }

  void _onAddTeacher(AddTeacherEvent event, Emitter<TeacherState> emit) {
    if (state is TeacherLoadedState) {
      final currentTeachers = (state as TeacherLoadedState).teachers;
      // Emit a new list reference so Equatable detects the change
      emit(TeacherLoadedState(List.from(currentTeachers)..add(event.teacher)));
    }
  }
}
