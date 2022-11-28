import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';

abstract class LessonFilesRepository extends StudentApiService {
  LessonFilesRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  Future<List<LessonFile>> getLessonFiles(String lessonId);

  Future<void> downloadFile(String fileId);
}

class AppLessonFilesRepository extends LessonFilesRepository {
  AppLessonFilesRepository(
      {required super.studentId, required super.token, required super.apiUrl});

  @override
  Future<List<LessonFile>> getLessonFiles(String lessonId) {
    // TODO: implement getLessonFiles
    throw UnimplementedError();
  }

  @override
  Future<void> downloadFile(String fileId) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }
}
