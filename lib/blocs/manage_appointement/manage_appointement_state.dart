abstract class ManageAppointementState {
  ManageAppointementState();

  Map<String, dynamic> get props => {};
}

class ManageAppointementInitial extends ManageAppointementState {}

class ManageAppointementLoading extends ManageAppointementState {}

class ManageAppointementSuccess extends ManageAppointementState {}

class ManageAppointementFailed extends ManageAppointementState {}
