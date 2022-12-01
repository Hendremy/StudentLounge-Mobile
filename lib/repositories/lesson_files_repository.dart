import 'dart:convert';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class LessonFilesRepository extends StudentApiService {
  final String downloadPath;
  LessonFilesRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required this.downloadPath});

  Future<List<LessonFile>?> getLessonFiles(String lessonId);

  Future<void> downloadFile(String fileId);
}

class AppLessonFilesRepository extends LessonFilesRepository {
  late String controllerUrl;
  AppLessonFilesRepository(
      {required super.studentId,
      required super.token,
      required super.apiUrl,
      required super.downloadPath}) {
    controllerUrl = '$apiUrl/LessonFile';
  }

  @override
  Future<List<LessonFile>?> getLessonFiles(String lessonId) async {
    Uri uri = Uri.parse("$controllerUrl/Lesson/$lessonId");
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
  Future<void> downloadFile(String fileId) async {
    String testUrl =
        "https://unece.org/fileadmin/DAM/env/pp/documents/cep43f.pdf";
    if (downloadPath.isEmpty) {
      throw Exception("Can't download - Access to directory denied");
    }
    await FlutterDownloader.enqueue(
        //url: '$controllerUrl/$fileId',
        url: testUrl,
        headers: tokenHeader,
        showNotification: true,
        openFileFromNotification: true,
        savedDir: downloadPath);
  }
}
