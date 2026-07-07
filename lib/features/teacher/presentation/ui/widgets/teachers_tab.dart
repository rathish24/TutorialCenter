import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:tutorial_management/features/teacher/presentation/bloc/teacher_state.dart';

class TeachersTab extends StatelessWidget {
  const TeachersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        return switch (state) {
          TeacherInitialState() || TeacherLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          TeacherErrorState(message: final message) => Center(
              child: Text(
                message,
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          TeacherLoadedState(teachers: final teachers) => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Teachers",
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        final teacher = teachers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(teacher.profileURL),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teacher.name,
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${teacher.gender}, ${teacher.age} years old",
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 14,
                                          color: colorScheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          teacher.contactNumber,
                                          style: TextStyle(
                                            color: colorScheme.onSurfaceVariant,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }
}
