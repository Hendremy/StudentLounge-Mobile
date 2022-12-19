abstract class AppointementState {}

class AskAppointementInitial extends AppointementState {}

class AskAppointementFailed extends AppointementState {
  AskAppointementFailed();
}

class AskAppointementSuccess extends AppointementState {
  final int tutoratId;

  AskAppointementSuccess({required this.tutoratId});
}
