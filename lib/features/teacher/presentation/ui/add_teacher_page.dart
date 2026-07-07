import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/core/navigation/app_navigator.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_event.dart';
import 'package:tutorial_management/core/helper/icontextfield.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';
import 'package:tutorial_management/core/theme/design_tokens.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final ageStr = _ageController.text.trim();
    final gender = _genderController.text.trim();
    final contact = _contactController.text.trim();

    if (name.isEmpty || ageStr.isEmpty || gender.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final age = int.tryParse(ageStr) ?? 0;

    // Generate a unique ID and a random profile avatar image URL
    final id = DateTime.now().millisecondsSinceEpoch;
    final profileURL = "https://i.pravatar.cc/150?img=${(id % 70) + 1}";

    final newTeacher = Teacher(
      name: name,
      profileURL: profileURL,
      id: id,
      age: age,
      gender: gender,
      contactNumber: contact,
    );

    context.read<TeacherBloc>().add(AddTeacherEvent(newTeacher));
    context.read<AppNavigator>().goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        title: const Text(
          "Add Teacher",
          style: TextStyle(color: AppColors.primaryText),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () => context.read<AppNavigator>().goBack(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              IconTextField(
                hint: "Name",
                icon: Icons.person,
                controller: _nameController,
              ),
              const SizedBox(height: 12),
              IconTextField(
                hint: "Age",
                icon: Icons.calendar_today,
                controller: _ageController,
              ),
              const SizedBox(height: 12),
              IconTextField(
                hint: "Gender",
                icon: Icons.man,
                controller: _genderController,
              ),
              const SizedBox(height: 12),
              IconTextField(
                hint: "Contact Number",
                icon: Icons.phone,
                controller: _contactController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: AppColors.textIcons,
                  foregroundColor: AppColors.primary,
                ),
                child: const Text("Add Teacher"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
