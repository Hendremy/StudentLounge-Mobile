import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class JoinLessonState{
  final Lesson lesson;

  JoinLessonState({required this.lesson});
}

class JoinLessonInitial extends JoinLessonState{
  JoinLessonInitial({required super.lesson});
}

class LessonLeavable extends JoinLessonState {
  LessonLeavable({required super.lesson});
}

class LessonJoinable extends JoinLessonState {
  LessonJoinable({required super.lesson});
}

class JoinLessonLoading extends JoinLessonState{
  JoinLessonLoading({required super.lesson});
}