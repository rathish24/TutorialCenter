import 'package:flutter/material.dart';
import 'package:tutorial_management/ui/widgets/teachers_tab.dart';
import 'package:tutorial_management/ui/widgets/students_tab.dart';
import 'package:tutorial_management/ui/widgets/home_tab.dart';
import 'package:tutorial_management/theme/design_tokens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeTab(
        onMoreTeachersTap: () => setState(() => _selectedIndex = 1),
        onMoreStudentsTap: () => setState(() => _selectedIndex = 2),
      ),
      const TeachersTab(),
      const StudentsTab(),
      const Center(
        child: Text(
          "Profile Tab",
          style: TextStyle(color: AppColors.primaryText, fontSize: 18),
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.textIcons,
          width: double.infinity,
          height: double.infinity,
          child: pages[_selectedIndex],
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
                color: _selectedIndex == 0
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => setState(() => _selectedIndex = 0),
              ),
              IconButton(
                icon: const Icon(Icons.school),
                color: _selectedIndex == 1
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => setState(() => _selectedIndex = 1),
              ),
              IconButton(
                icon: const Icon(Icons.people),
                color: _selectedIndex == 2
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => setState(() => _selectedIndex = 2),
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                color: _selectedIndex == 3
                    ? AppColors.textIcons
                    : AppColors.textIcons.withValues(alpha: 0.5),
                onPressed: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
