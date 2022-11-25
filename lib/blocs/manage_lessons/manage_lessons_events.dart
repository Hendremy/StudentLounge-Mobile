import 'package:studentlounge_mobile/models/lesson_model.dart';

abstract class ManageLessonsEvent {
  Map<String, dynamic> get props => {};
}

class RetryLoadLessonsEvent extends ManageLessonsEvent {}
