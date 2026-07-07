import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/features/student/presentation/bloc/student_bloc.dart';
import 'package:tutorial_management/features/student/presentation/bloc/student_state.dart';
import 'package:tutorial_management/features/teacher/presentation/ui/widgets/generic_home_grid.dart';

class StudentsHomeList extends StatelessWidget {
  const StudentsHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return switch (state) {
          StudentInitialState() || StudentLoadingState() => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            ),
          StudentErrorState(message: final message) => Center(
              child: Text(
                message,
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          StudentAddedState() => const SizedBox.shrink(),
          StudentLoadedState(students: final students) => GenericHomeGrid(
              items: students,
              getName: (student) => student.name,
              getImageUrl: (student) => student.profileURL,
            ),
        };
      },
    );
  }
}
