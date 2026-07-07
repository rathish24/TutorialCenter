import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/core/navigation/app_navigator.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_event.dart';
import 'package:tutorial_management/core/helper/icontextfield.dart';
import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

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
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text) ?? 0;
    final gender = _genderController.text;
    final contact = _contactController.text;
    final id = DateTime.now().millisecondsSinceEpoch;

    // Use a placeholder image URL for testing
    const profileURL = 'https://picsum.photos/200';

    if (name.isEmpty || age == 0 || gender.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text(
          "Add Teacher",
          style: TextStyle(color: colorScheme.onPrimaryContainer),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
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
                  backgroundColor: colorScheme.surface,
                  foregroundColor: colorScheme.primary,
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
