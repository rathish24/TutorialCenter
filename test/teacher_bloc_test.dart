import 'package:flutter_test/flutter_test.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/models/teacher.dart';

void main() {
  group('TeacherBloc Tests', () {
    late TeacherBloc teacherBloc;

    setUp(() {
      teacherBloc = TeacherBloc();
    });

    tearDown(() {
      teacherBloc.close();
    });

    test('initial state is TeacherInitialState', () {
      expect(teacherBloc.state, const TeacherInitialState());
    });

    test('LoadTeachersEvent emits TeacherLoadingState and then TeacherLoadedState', () {
      final expectedStates = [
        const TeacherLoadingState(),
        isA<TeacherLoadedState>(),
      ];

      expectLater(teacherBloc.stream, emitsInOrder(expectedStates));

      teacherBloc.add(const LoadTeachersEvent());
    });

    test('AddTeacherEvent adds a teacher to the list when state is TeacherLoadedState', () async {
      teacherBloc.add(const LoadTeachersEvent());
      // Wait for it to load
      await expectLater(
        teacherBloc.stream,
        emitsThrough(isA<TeacherLoadedState>()),
      );

      final initialLoadedState = teacherBloc.state as TeacherLoadedState;
      final initialCount = initialLoadedState.teachers.length;

      final newTeacher = Teacher(
        id: 99,
        name: "Test Teacher",
        profileURL: "https://example.com/img.png",
        age: 30,
        gender: "Male",
        contactNumber: "123-456-7890",
      );

      teacherBloc.add(AddTeacherEvent(newTeacher));

      await expectLater(
        teacherBloc.stream,
        emits(
          predicate<TeacherState>((state) {
            if (state is TeacherLoadedState) {
              return state.teachers.length == initialCount + 1 &&
                  state.teachers.last.name == "Test Teacher";
            }
            return false;
          }),
        ),
      );
    });
  });
}
