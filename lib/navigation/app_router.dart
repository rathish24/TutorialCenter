import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_management/ui/home_screen.dart';
import 'package:tutorial_management/ui/widgets/home_tab.dart';
import 'package:tutorial_management/ui/widgets/teachers_tab.dart';
import 'package:tutorial_management/ui/widgets/students_tab.dart';
import 'package:tutorial_management/theme/design_tokens.dart';
import 'package:tutorial_management/ui/add_teacher_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/navigation/app_navigator.dart';

class AppRouter {
  static const String home = '/home';
  static const String teacher = '/teacher';
  static const String student = '/student';
  static const String profile = '/profile';
  static const String addTeacher = '/add-teacher';

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => HomeTab(
                  onMoreTeachersTap: () => context.read<AppNavigator>().goToTeacher(),
                  onMoreStudentsTap: () => context.read<AppNavigator>().goToStudent(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: teacher,
                builder: (context, state) => const TeachersTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: student,
                builder: (context, state) => const StudentsTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const Center(
                  child: Text(
                    "Profile Tab",
                    style: TextStyle(color: AppColors.primaryText, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: addTeacher,
        builder: (context, state) => const AddTeacherPage(),
      ),
    ],
  );
}
