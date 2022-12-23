import 'dart:convert';
import 'dart:io' as io;
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonFilesRepository extends StudentApiService {
  final String downloadPath;
  LessonFilesRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller,
      required this.downloadPath});

  Future<List<LessonFile>?> getLessonFiles(String lessonId);

  Future<String> downloadFile(String fileId, String fileName);
}

class AppLessonFilesRepository extends LessonFilesRepository {
  AppLessonFilesRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.controller,
      required super.downloadPath});

  @override
  Future<List<LessonFile>?> getLessonFiles(String lessonId) async {
    Uri uri = Uri.parse("$controllerUrl/lesson/$lessonId");
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
  Future<String> downloadFile(String fileId, String fileName) async {
    if (downloadPath.isEmpty) {
      throw Exception("Can't download - Access to directory denied");
    }
    Uri downloadUrl = Uri.parse("$controllerUrl/$fileId");
    http.Response response = await http.get(downloadUrl, headers: tokenHeader);

    io.File file = io.File("$downloadPath/$fileName");
    var result = await file.writeAsBytes(response.bodyBytes,
        mode: io.FileMode.write, flush: true);
    return result.path;
  }
}
