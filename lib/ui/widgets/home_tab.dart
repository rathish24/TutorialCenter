import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/navigation/app_navigator.dart';
import 'package:tutorial_management/theme/design_tokens.dart';
import 'package:tutorial_management/ui/widgets/teachers_home_list.dart';
import 'package:tutorial_management/ui/widgets/students_home_list.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onMoreTeachersTap;
  final VoidCallback onMoreStudentsTap;

  const HomeTab({
    super.key,
    required this.onMoreTeachersTap,
    required this.onMoreStudentsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Rathish ",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Teachers ",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 25,
                    color: AppColors.primary,
                    onPressed: () {
                      context.read<AppNavigator>().goToAddTeacher();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const TeachersHomeList(),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: onMoreTeachersTap,
                  child: const Text(
                    "More Teachers ",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Students ",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 12),
              const StudentsHomeList(),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: onMoreStudentsTap,
                  child: const Text(
                    "More Students ",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
