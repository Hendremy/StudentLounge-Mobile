import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class LessonListState {}

class LessonListInitial extends LessonListState {}

class LessonListLoading extends LessonListState {}

class LessonListLoadingFailed extends LessonListState {
  final String error;

  LessonListLoadingFailed({required this.error});
}

class LessonListLoaded extends LessonListState {
  final List<Lesson> lessonList;

  LessonListLoaded({required this.lessonList});
}
