import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_event.dart';
import 'package:tutorial_management/core/theme/design_tokens.dart';
import 'package:tutorial_management/core/navigation/app_navigator.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.textIcons,
          width: double.infinity,
          height: double.infinity,
          child: navigationShell,
        ),
      ),
      backgroundColor: AppColors.darkPrimary,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.darkPrimary,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: navigationShell.currentIndex == 0
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () {
                  context.read<AppNavigator>().goToHome();
                  context.read<TeacherBloc>().add(const LoadTeachersEvent());
                },
              ),
              IconButton(
                icon: const Icon(Icons.school),
                color: navigationShell.currentIndex == 1
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => context.read<AppNavigator>().goToTeacher(),
              ),
              IconButton(
                icon: const Icon(Icons.people),
                color: navigationShell.currentIndex == 2
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => context.read<AppNavigator>().goToStudent(),
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                color: navigationShell.currentIndex == 3
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => context.read<AppNavigator>().goToProfile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
