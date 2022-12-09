import 'package:studentlounge_mobile/models/tutorat_model.dart';

abstract class TutoratListEvent {}

class TutoratSelected extends TutoratListEvent {
  final String tutoratName;

  TutoratSelected(this.tutoratName);
}

class TutoratListLoadRetry extends TutoratListEvent {}

class TutoratListUpdated extends TutoratListEvent {
  final List<Tutorat> tutoratList;

  TutoratListUpdated({required this.tutoratList});
}
