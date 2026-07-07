import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_state.dart';
import 'package:tutorial_management/features/teacher/presentation/ui/widgets/generic_home_grid.dart';

class TeachersHomeList extends StatelessWidget {
  const TeachersHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoadingState || state is TeacherInitialState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TeacherErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: colorScheme.error),
            ),
          );
        } else if (state is TeacherLoadedState) {
          return GenericHomeGrid(
            items: state.teachers,
            getName: (teacher) => teacher.name,
            getImageUrl: (teacher) => teacher.profileURL,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
