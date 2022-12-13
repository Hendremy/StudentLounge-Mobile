import 'dart:convert';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonsRepository extends StudentApiService {
  LessonsRepository(
      {required super.studentId, required super.token,
       required super.apiUrl, required super.controller});

  Future<dynamic> getAllLessons();
  Future<dynamic> getUserLessons();
  Future<Lesson> joinLesson(String lessonId);
  Future<Lesson> leaveLesson(String lessonId);
}

class AppLessonsRepository extends LessonsRepository {
  AppLessonsRepository(
      {required super.studentId, required super.token,
       required super.apiUrl, required super.controller});

  @override
  Future<dynamic> getAllLessons() async {
    return await getLessonList("/all");
  }

  @override
  Future<dynamic> getUserLessons() async {
    return await getLessonList("");
  }

  Future<List<Lesson>?> getLessonList(String options) async {
    http.Response response = await http.get(Uri.parse('$controllerUrl$options'),
        headers: jsonHeaders);
    if (response.statusCode == 200) {
      return convertJSONLessonList(response.body);
    }
    return null;
  }

  @override
  Future<Lesson> joinLesson(String lessonId) async {
    return await manageLesson(true, lessonId);
  }

  @override
  Future<Lesson> leaveLesson(String lessonId) async {
    return await manageLesson(false, lessonId);
  }

  Future<Lesson> manageLesson(bool join, String lessonId) async {
    Uri uri = Uri.parse('$controllerUrl/$lessonId');
    http.Response response = join
        ? await http.put(uri, headers: jsonHeaders)
        : await http.delete(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return Lesson.fromMap(jsonMap);
    }
    return Lesson.empty();
  }

  List<Lesson> convertJSONLessonList(String jsonList) {
    List<dynamic> lessonMapList = jsonDecode(jsonList);
    List<Lesson> lessonList = [];
    for (var lessonMap in lessonMapList) {
      lessonList.add(Lesson.fromMap(lessonMap));
    }
    return lessonList;
  }
}
