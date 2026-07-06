import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/theme/design_tokens.dart';
import 'package:tutorial_management/ui/widgets/generic_home_grid.dart';

class TeachersHomeList extends StatelessWidget {
  const TeachersHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoadingState || state is TeacherInitialState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is TeacherErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
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
