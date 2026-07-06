import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorial_management/data/datasources/teacher_remote_datasource.dart';
import 'package:tutorial_management/models/teacher.dart';

class TeacherFirebaseDatasource implements TeacherRemoteDatasource {
  final FirebaseFirestore firestore;

  TeacherFirebaseDatasource({required this.firestore});

  @override
  Future<List<Teacher>> getTeachers() async {
    final snapshot = await firestore.collection('teachers').get();
    return snapshot.docs.map((doc) => Teacher.fromMap(doc.data())).toList();
  }

  @override
  Future<void> addTeacher(Teacher teacher) async {
    await firestore
        .collection('teachers')
        .doc(teacher.id.toString())
        .set(teacher.toMap());
  }
}
