import 'package:tutorial_management/navigation/app_router.dart';

abstract class AppNavigator {
  void goToHome();
  void goToTeacher();
  void goToStudent();
  void goToProfile();
  void goToAddTeacher();
  void goBack();
}

class AppNavigatorImpl implements AppNavigator {
  final AppRouter appRouter;

  AppNavigatorImpl(this.appRouter);

  @override
  void goToHome() {
    appRouter.router.go(AppRouter.home);
  }

  @override
  void goToStudent() {
    appRouter.router.go(AppRouter.student);
  }

  @override
  void goToTeacher() {
    appRouter.router.go(AppRouter.teacher);
  }

  @override
  void goToProfile() {
    appRouter.router.go(AppRouter.profile);
  }

  @override
  void goToAddTeacher() {
    appRouter.router.push(AppRouter.addTeacher);
  }

  @override
  void goBack() {
    appRouter.router.pop();
  }
}
