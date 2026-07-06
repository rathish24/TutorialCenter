import 'package:hive/hive.dart';
import 'package:tutorial_management/data/datasources/teacher_local_datasource.dart';
import 'package:tutorial_management/models/teacher.dart';

class HiveTeacherDatasource implements TeacherLocalDatasource {
  final Box box;

  HiveTeacherDatasource({required this.box});

  @override
  Future<List<Teacher>> getCachedTeachers() async {
    final rawData = box.get('teachers_list', defaultValue: []);
    final List<dynamic> rawList = List<dynamic>.from(rawData);
    return rawList.map((item) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(item as Map);
      return Teacher.fromMap(map);
    }).toList();
  }

  @override
  Future<void> cacheTeachers(List<Teacher> teachers) async {
    final rawList = teachers.map((t) => t.toMap()).toList();
    await box.put('teachers_list', rawList);
  }

  @override
  Future<void> cacheSingleTeacher(Teacher teacher) async {
    final cached = await getCachedTeachers();
    cached.add(teacher);
    await cacheTeachers(cached);
  }
}
