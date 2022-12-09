import 'package:studentlounge_mobile/models/tutorat_model.dart';

abstract class JoinTutoratState {
  final Tutorat tutorat;

  JoinTutoratState({required this.tutorat});
}

class JoinTutoratInitial extends JoinTutoratState {
  JoinTutoratInitial({required super.tutorat});
}

class TutoratDisable extends JoinTutoratState {
  TutoratDisable({required super.tutorat});
}

class TutoratJoinable extends JoinTutoratState {
  TutoratJoinable({required super.tutorat});
}

class JoinTutoratLoading extends JoinTutoratState {
  JoinTutoratLoading({required super.tutorat});
}
