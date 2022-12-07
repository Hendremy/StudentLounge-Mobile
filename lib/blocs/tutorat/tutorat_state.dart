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

class AcceptTutoratSuccess extends TutoratState {
  final String lessonId;

  AcceptTutoratSuccess({required this.lessonId});
}

class AcceptTutoratFailed extends TutoratState {
  final String lessonId;

  AcceptTutoratFailed({required this.lessonId});
}

class GetTutoratSuccess extends TutoratState {
  final String tutoratId;

  GetTutoratSuccess({required this.tutoratId});
}

class GetTutoratFailed extends TutoratState {
  final String tutoratId;

  GetTutoratFailed({required this.tutoratId});
}
