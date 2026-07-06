import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_bloc.dart';
import 'package:tutorial_management/bloc/teacher/teacher_state.dart';
import 'package:tutorial_management/models/teacher.dart';
import 'package:tutorial_management/ui/add_teacher_page.dart';
import 'package:tutorial_management/ui/widgets/teacher_card.dart';
import 'package:tutorial_management/ui/widgets/teachers_tab.dart';
import 'package:tutorial_management/theme/design_tokens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  Widget _buildHomeTab(List<Teacher> teachers) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTeacherPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  return TeacherCard(
                    name: teacher.name,
                    imageUrl: teacher.profileURL,
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1; // Go to Teachers exclusive tab!
                    });
                  },
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoadingState || state is TeacherInitialState) {
          return const Scaffold(
            backgroundColor: AppColors.darkPrimary,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.textIcons),
            ),
          );
        } else if (state is TeacherErrorState) {
          return Scaffold(
            backgroundColor: AppColors.darkPrimary,
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else if (state is TeacherLoadedState) {
          final teachers = state.teachers;
          final List<Widget> pages = [
            _buildHomeTab(teachers),
            TeachersTab(teachers: teachers),
            const Center(
              child: Text(
                "Favorites Tab",
                style: TextStyle(color: AppColors.primaryText, fontSize: 18),
              ),
            ),
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
                      icon: const Icon(Icons.favorite_border_outlined),
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
        return const SizedBox.shrink();
      },
    );
  }
}
