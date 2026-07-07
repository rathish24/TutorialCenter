import 'package:tutorial_management/features/student/domain/entities/student.dart';

/// Data Transfer Object (DTO) for Student serialization.
class StudentModel extends Student {
  const StudentModel({
    required super.name,
    required super.profileURL,
    required super.id,
    required super.age,
    required super.gender,
    required super.contactNumber,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
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

  factory StudentModel.fromEntity(Student entity) {
    return StudentModel(
      name: entity.name,
      profileURL: entity.profileURL,
      id: entity.id,
      age: entity.age,
      gender: entity.gender,
      contactNumber: entity.contactNumber,
    );
  }
}
