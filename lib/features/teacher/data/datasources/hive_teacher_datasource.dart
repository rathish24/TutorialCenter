import 'package:tutorial_management/core/cache/local_database_client.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

class HiveTeacherDatasource implements TeacherLocalDatasource {
  final LocalDatabaseClient localDatabaseClient;

  HiveTeacherDatasource({required this.localDatabaseClient});

  @override
  Future<List<TeacherModel>> getCachedTeachers() async {
    final rawData = localDatabaseClient.get('teachers_list', defaultValue: []);
    final List<dynamic> rawList = List<dynamic>.from(rawData);
    return rawList.map((item) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(item as Map);
      return TeacherModel.fromMap(map);
    }).toList();
  }

  @override
  Future<void> cacheTeachers(List<TeacherModel> teachers) async {
    final rawList = teachers.map((t) => t.toMap()).toList();
    await localDatabaseClient.put('teachers_list', rawList);
  }

  @override
  Future<void> cacheSingleTeacher(TeacherModel teacher) async {
    final cached = await getCachedTeachers();
    cached.add(teacher);
    await cacheTeachers(cached);
  }
}
