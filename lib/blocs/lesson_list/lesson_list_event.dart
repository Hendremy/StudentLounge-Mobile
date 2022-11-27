import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class LessonListEvent {}

class LessonSelected extends LessonListEvent {
  final String lessonName;

  LessonSelected(this.lessonName);
}

class LessonListLoadRetry extends LessonListEvent {}

class LessonListUpdated extends LessonListEvent {
  final List<Lesson> lessonList;

  LessonListUpdated({required this.lessonList});
}
