abstract class LessonEvent {}

class LessonSelected extends LessonEvent {
  final String lessonName;

  LessonSelected(this.lessonName);
}

class LessonListLoadRetry extends LessonEvent {}
