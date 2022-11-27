import 'package:studentlounge_mobile/models/lesson_file_model.dart';

abstract class LessonEvent {}

class FilesLoadSuccess extends LessonEvent {
  final List<LessonFile> files;

  FilesLoadSuccess({required this.files});
}

class FilesLoadFail extends LessonEvent {
  final String errorMessage;

  FilesLoadFail({required this.errorMessage});
}
