import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class LessonListEvent {}

class LessonSelected extends LessonListEvent {
  final String lessonName;

  LessonSelected(this.lessonName);
}

class LessonListLoadRetry extends LessonListEvent {}

class LessonAdded extends LessonListEvent {
  final Lesson lesson;

  LessonAdded({required this.lesson});
}

class LessonRemoved extends LessonListEvent {
  final Lesson lesson;

  LessonRemoved({required this.lesson});
}
