import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class JoinLessonState{
  final Lesson lesson;

  JoinLessonState({required this.lesson});
}

class JoinLessonInitial extends JoinLessonState{
  JoinLessonInitial({required super.lesson});
}

class LessonJoined extends JoinLessonState {
  LessonJoined({required super.lesson});
}

class LessonLeft extends JoinLessonState {
  LessonLeft({required super.lesson});
}

class JoinLessonLoading extends JoinLessonState{
  JoinLessonLoading({required super.lesson});
}