import 'dart:convert';

import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonFilesRepository extends StudentApiService {
  LessonFilesRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  Future<List<LessonFile>?> getLessonFiles(String lessonId);

  Future<void> downloadFile(String fileId);
}

class AppLessonFilesRepository extends LessonFilesRepository {
  late String controllerUrl;
  AppLessonFilesRepository(
      {required super.studentId, required super.token, required super.apiUrl}){
        controllerUrl = '$apiUrl/LessonFile';
      }

  @override
  Future<List<LessonFile>?> getLessonFiles(String lessonId) async {
    Uri uri = Uri.parse(controllerUrl);
    http.Response response = await http.get(uri, headers: jsonHeaders);
    if (response.statusCode == 200) {
      return convertJSONFileList(response.body);
    }
    return null;
  }

  List<LessonFile> convertJSONFileList(String jsonList) {
    List<dynamic> fileMapList = jsonDecode(jsonList);
    List<LessonFile> fileList = [];
    for (var fileMap in fileMapList) {
      fileList.add(LessonFile.fromMap(fileMap));
    }
    return fileList;
  }

  @override
  Future<void> downloadFile(String fileId) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }
}
