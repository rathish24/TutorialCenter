import 'package:tutorial_management/core/cache/hive_client.dart';
import 'package:tutorial_management/features/teacher/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/features/teacher/data/models/teacher_model.dart';

class HiveTeacherDatasource implements TeacherLocalDatasource {
  final HiveClient hiveClient;

  HiveTeacherDatasource({required this.hiveClient});

  @override
  Future<List<TeacherModel>> getCachedTeachers() async {
    final rawData = hiveClient.get('teachers_list', defaultValue: []);
    final List<dynamic> rawList = List<dynamic>.from(rawData);
    return rawList.map((item) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(item as Map);
      return TeacherModel.fromMap(map);
    }).toList();
  }

  @override
  Future<void> cacheTeachers(List<TeacherModel> teachers) async {
    final rawList = teachers.map((t) => t.toMap()).toList();
    await hiveClient.put('teachers_list', rawList);
  }

  @override
  Future<void> cacheSingleTeacher(TeacherModel teacher) async {
    final cached = await getCachedTeachers();
    cached.add(teacher);
    await cacheTeachers(cached);
  }
}
