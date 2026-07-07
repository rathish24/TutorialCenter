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
        if (state is StudentLoadingState || state is StudentInitialState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is StudentErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: colorScheme.error),
            ),
          );
        } else if (state is StudentLoadedState) {
          return GenericHomeGrid(
            items: state.students,
            getName: (student) => student.name,
            getImageUrl: (student) => student.profileURL,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
