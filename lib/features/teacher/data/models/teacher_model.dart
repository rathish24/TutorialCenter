import 'package:tutorial_management/features/teacher/domain/entities/teacher.dart';

/// Data Transfer Object (DTO) for Teacher serialization.
class TeacherModel extends Teacher {
  const TeacherModel({
    required super.name,
    required super.profileURL,
    required super.id,
    required super.age,
    required super.gender,
    required super.contactNumber,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      name: map['name'] ?? '',
      profileURL: map['profileURL'] ?? '',
      id: map['id'] ?? 0,
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileURL': profileURL,
      'id': id,
      'age': age,
      'gender': gender,
      'contactNumber': contactNumber,
    };
  }

  factory TeacherModel.fromEntity(Teacher entity) {
    return TeacherModel(
      name: entity.name,
      profileURL: entity.profileURL,
      id: entity.id,
      age: entity.age,
      gender: entity.gender,
      contactNumber: entity.contactNumber,
    );
  }
}
