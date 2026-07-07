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
        return switch (state) {
          TeacherInitialState() || TeacherLoadingState() => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            ),
          TeacherErrorState(message: final message) => Center(
              child: Text(
                message,
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          TeacherLoadedState(teachers: final teachers) => GenericHomeGrid(
              items: teachers,
              getName: (teacher) => teacher.name,
              getImageUrl: (teacher) => teacher.profileURL,
            ),
        };
      },
    );
  }
}
