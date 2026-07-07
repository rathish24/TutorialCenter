import 'package:tutorial_management/core/firebase/firestore_client.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_remote_datasource.dart';
import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

class TeacherFirebaseDatasource implements TeacherRemoteDatasource {
  final FirestoreClient firestoreClient;

  TeacherFirebaseDatasource({required this.firestoreClient});

  @override
  Future<List<TeacherModel>> getTeachers() async {
    return await firestoreClient.getCollection<TeacherModel>(
      path: 'teachers',
      fromJson: (data) => TeacherModel.fromMap(data),
    );
  }

  @override
  Future<void> addTeacher(TeacherModel teacher) async {
    await firestoreClient.setDocument(
      path: 'teachers/${teacher.id}',
      data: teacher.toMap(),
    );
  }
}
