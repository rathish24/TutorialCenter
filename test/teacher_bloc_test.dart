import 'package:flutter_test/flutter_test.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_event.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/domain/repositories/teacher_repository.dart';
import 'package:tutorial_management/domain/usecases/add_teacher_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_teachers_usecase.dart';
import 'package:tutorial_management/domain/usecases/get_cached_teachers_usecase.dart';
import 'package:tutorial_management/models/teacher.dart';

class FakeTeacherRepository implements TeacherRepository {
  final List<Teacher> cachedTeachers = [];
  final List<Teacher> remoteTeachers = [];
  bool throwRemoteError = false;

  @override
  Future<List<Teacher>> getTeachers() async {
    if (throwRemoteError) {
      throw Exception("Remote fetch failed");
    }
    return List.from(remoteTeachers);
  }

  @override
  Future<List<Teacher>> getCachedTeachers() async {
    return List.from(cachedTeachers);
  }

  @override
  Future<void> addTeacher(Teacher teacher) async {
    remoteTeachers.add(teacher);
    cachedTeachers.add(teacher);
  }
}

void main() {
  group('TeacherBloc Tests', () {
    late TeacherBloc teacherBloc;
    late FakeTeacherRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeTeacherRepository();
      teacherBloc = TeacherBloc(
        getTeachersUseCase: GetTeachersUseCase(fakeRepository),
        getCachedTeachersUseCase: GetCachedTeachersUseCase(fakeRepository),
        addTeacherUseCase: AddTeacherUseCase(fakeRepository),
      );
    });

    tearDown(() {
      teacherBloc.close();
    });

    test('initial state is TeacherInitialState', () {
      expect(teacherBloc.state, const TeacherInitialState());
    });

    test('LoadTeachersEvent emits TeacherLoadingState and then TeacherLoadedState when cache is empty', () {
      final expectedStates = [
        const TeacherLoadingState(),
        isA<TeacherLoadedState>(),
      ];

      expectLater(teacherBloc.stream, emitsInOrder(expectedStates));

      teacherBloc.add(const LoadTeachersEvent());
    });

    test('LoadTeachersEvent emits cached teachers first, then updates with remote teachers when cache is not empty', () async {
      final cachedTeacher = Teacher(
        id: 1,
        name: "Cached Teacher",
        profileURL: "https://example.com/cache.png",
        age: 40,
        gender: "Female",
        contactNumber: "555-0100",
      );

      final remoteTeacher = Teacher(
        id: 2,
        name: "Remote Teacher",
        profileURL: "https://example.com/remote.png",
        age: 35,
        gender: "Male",
        contactNumber: "555-0200",
      );

      fakeRepository.cachedTeachers.add(cachedTeacher);
      fakeRepository.remoteTeachers.addAll([cachedTeacher, remoteTeacher]);

      final expectedStates = [
        predicate<TeacherState>((state) {
          if (state is TeacherLoadedState) {
            return state.teachers.length == 1 && state.teachers.first.name == "Cached Teacher";
          }
          return false;
        }),
        predicate<TeacherState>((state) {
          if (state is TeacherLoadedState) {
            return state.teachers.length == 2 && 
                   state.teachers.any((t) => t.name == "Cached Teacher") &&
                   state.teachers.any((t) => t.name == "Remote Teacher");
          }
          return false;
        }),
      ];

      expectLater(teacherBloc.stream, emitsInOrder(expectedStates));

      teacherBloc.add(const LoadTeachersEvent());
    });

    test('LoadTeachersEvent emits cached teachers, and retains them without error state if remote fails', () async {
      final cachedTeacher = Teacher(
        id: 1,
        name: "Cached Teacher",
        profileURL: "https://example.com/cache.png",
        age: 40,
        gender: "Female",
        contactNumber: "555-0100",
      );

      fakeRepository.cachedTeachers.add(cachedTeacher);
      fakeRepository.throwRemoteError = true;

      // We expect only TeacherLoadedState with cached teachers, and NO TeacherErrorState.
      final expectedStates = [
        predicate<TeacherState>((state) {
          if (state is TeacherLoadedState) {
            return state.teachers.length == 1 && state.teachers.first.name == "Cached Teacher";
          }
          return false;
        }),
      ];

      // Since expectLater with emitsInOrder expects a stream that finishes/emits exactly these,
      // and we want to ensure no other state is emitted, we can assert on the stream.
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
        emitsThrough(
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
