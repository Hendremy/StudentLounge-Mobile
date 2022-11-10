import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();
}

class LessonButtonPressed extends LessonEvent {
  final String lessonName;

  const LessonButtonPressed(this.lessonName);


  @override
  // TODO: implement props
  List<Object> get props => [lessonName];

  @override
  String toString() =>
      'LessonButtonPressed { lessonName: $lessonName }';
}