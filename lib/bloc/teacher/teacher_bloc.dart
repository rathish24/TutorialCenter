import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final GetTeachersUseCase getTeachersUseCase;
  final AddTeacherUseCase addTeacherUseCase;

  TeacherBloc({
    required this.getTeachersUseCase,
    required this.addTeacherUseCase,
  }) : super(const TeacherInitialState()) {
    on<LoadTeachersEvent>(_onLoadTeachers);
    on<AddTeacherEvent>(_onAddTeacher);
  }

  Future<void> _onLoadTeachers(LoadTeachersEvent event, Emitter<TeacherState> emit) async {
    emit(const TeacherLoadingState());
    try {
      final teachers = await getTeachersUseCase();
      emit(TeacherLoadedState(teachers));
    } catch (e) {
      emit(TeacherErrorState(e.toString()));
    }
  }

  Future<void> _onAddTeacher(AddTeacherEvent event, Emitter<TeacherState> emit) async {
    final currentState = state;
    try {
      await addTeacherUseCase(event.teacher);
      add(const LoadTeachersEvent());
    } catch (e) {
      emit(TeacherErrorState(e.toString()));
      if (currentState is TeacherLoadedState) {
        emit(currentState);
      }
    }
  }
}
