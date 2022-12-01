import 'package:studentlounge_mobile/models/lesson_file_model.dart';

abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonFilesLoading extends LessonState {}

class LessonFilesLoaded extends LessonState {
  final List<LessonFile> lessonFiles;

  LessonFilesLoaded({required this.lessonFiles});
}

class LessonFilesLoadFailed extends LessonState {}
