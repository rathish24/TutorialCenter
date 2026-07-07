import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/core/errors/result.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_event.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_state.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final GetTeachersUseCase getTeachersUseCase;
  final GetCachedTeachersUseCase getCachedTeachersUseCase;
  final AddTeacherUseCase addTeacherUseCase;

  bool _hasFetchedRemote = false;

  TeacherBloc({
    required this.getTeachersUseCase,
    required this.getCachedTeachersUseCase,
    required this.addTeacherUseCase,
  }) : super(const TeacherInitialState()) {
    on<LoadTeachersEvent>(_onLoadTeachers);
    on<AddTeacherEvent>(_onAddTeacher);
  }

  Future<void> _onLoadTeachers(LoadTeachersEvent event, Emitter<TeacherState> emit) async {
    // If we already fetched from Firebase this session, skip the API call completely
    if (_hasFetchedRemote && state is TeacherLoadedState) {
      return;
    }

    List<Teacher> cachedTeachers = [];
    final cachedResult = await getCachedTeachersUseCase();

    switch (cachedResult) {
      case Success(value: final teachers):
        cachedTeachers = teachers;
        if (cachedTeachers.isNotEmpty) {
          emit(TeacherLoadedState(List.from(cachedTeachers)));
        } else if (state is! TeacherLoadedState) {
          emit(const TeacherLoadingState());
        }
      case ErrorResult():
        if (state is! TeacherLoadedState) {
          emit(const TeacherLoadingState());
        }
    }

    final remoteResult = await getTeachersUseCase();

    switch (remoteResult) {
      case Success(value: final remoteTeachers):
        _hasFetchedRemote = true;
        emit(TeacherLoadedState(remoteTeachers));
      case ErrorResult(error: final failure):
        if (cachedTeachers.isEmpty) {
          emit(TeacherErrorState(failure.message));
        }
    }
  }

  Future<void> _onAddTeacher(AddTeacherEvent event, Emitter<TeacherState> emit) async {
    final currentState = state;
    final result = await addTeacherUseCase(event.teacher);

    switch (result) {
      case Success():
        // Update state in memory directly so we don't need to call the Firebase API again
        if (currentState is TeacherLoadedState) {
          emit(TeacherLoadedState(List.from(currentState.teachers)..add(event.teacher)));
        } else {
          // If we weren't loaded yet, fetch now
          add(const LoadTeachersEvent());
        }
      case ErrorResult(error: final failure):
        emit(TeacherErrorState(failure.message));
        if (currentState is TeacherLoadedState) {
          emit(currentState);
        }
    }
  }
}
