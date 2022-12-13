import 'dart:io';

abstract class ApiService {
  final String apiUrl;
  final String controller;

  String get controllerUrl => '$apiUrl/$controller';

  ApiService({required this.apiUrl, required this.controller});
}

abstract class StudentApiService extends ApiService {
  final String studentId;
  final String token;

  Map<String, String> get jsonHeaders => <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

  Map<String, String> get tokenHeader =>
      <String, String>{HttpHeaders.authorizationHeader: 'Bearer $token'};

  StudentApiService(
      {required this.studentId, required this.token, required super.apiUrl, required super.controller});
}
