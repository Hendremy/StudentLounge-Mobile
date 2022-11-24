import 'dart:io';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonsRepository extends StudentApiService {
  LessonsRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  Future<dynamic> getLesson(String lessonName);
  Future<dynamic> getAllLessons();
  Future<dynamic> getUserLessons();
  Future<bool> joinLesson(int lessonId);
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
    return null;
  }

  @override
  Future<dynamic> getUserLessons() async {
    http.Response response = await http.get(
        Uri.parse('$controllerUrl/user/$studentId'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        });
    if (response.statusCode == 200) {
      //TODO: Continuer
    }
    return null;
  }

  @override
  Future<bool> joinLesson(int lessonId) async {
    http.Response response = await http.put(
        Uri.parse('$controllerUrl/$lessonId/user/$studentId'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        });
    return response.statusCode == 200;
  }
}
