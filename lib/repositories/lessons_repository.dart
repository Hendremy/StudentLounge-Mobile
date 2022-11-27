import 'dart:convert';
import 'dart:io';
import 'package:studentlounge_mobile/models/lesson_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonsRepository extends StudentApiService {
  LessonsRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  Future<dynamic> getLesson(String lessonName);
  Future<dynamic> getAllLessons();
  Future<dynamic> getUserLessons();
  Future<Lesson> joinLesson(int lessonId);
  Future<Lesson> leaveLesson(int lessonId);
}

class AppLessonsRepository extends LessonsRepository {
  late String controllerUrl;
  AppLessonsRepository(
      {required super.studentId, required super.token, required super.apiUrl}) {
    controllerUrl = '$apiUrl/Lessons';
  }

  @override
  Future<dynamic> getLesson(String lessonName) async {
    return null;
  }

  @override
  Future<dynamic> getAllLessons() async {
    return await getLessonList("");
  }

  @override
  Future<dynamic> getUserLessons() async {
    return await getLessonList(studentId);
  }

  Future<List<Lesson>?> getLessonList(String userId) async {
    String userIdRouteParam = userId.isNotEmpty ? "/user/$userId" : "";
    http.Response response = await http.get(
        Uri.parse('$controllerUrl$userIdRouteParam'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        });
    if (response.statusCode == 200) {
      return convertJSONLessonList(response.body);
    }
    return null;
  }

  @override
  Future<Lesson> joinLesson(int lessonId) async {
    return await manageLesson(true, lessonId);
  }

  @override
  Future<Lesson> leaveLesson(int lessonId) async {
    return await manageLesson(false, lessonId);
  }

  Future<Lesson> manageLesson(bool join, int lessonId) async {
    Uri uri = Uri.parse('$controllerUrl/$lessonId/user/$studentId');
    http.Response response = join
        ? await http.put(uri, headers: headers)
        : await http.delete(uri, headers: headers);
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
