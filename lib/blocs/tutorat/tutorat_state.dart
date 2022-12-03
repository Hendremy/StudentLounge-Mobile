abstract class TutoratState {}

class TutoratInitial extends TutoratState {}

class AskTutoratFailed extends TutoratState {
  final String lessonId;

  AskTutoratFailed({required this.lessonId});
}

class AskTutoratSuccess extends TutoratState {
  final String lessonId;

  AskTutoratSuccess({required this.lessonId});
}
