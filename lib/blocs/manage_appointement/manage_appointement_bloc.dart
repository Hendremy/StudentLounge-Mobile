import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_events.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_state.dart';
import 'package:studentlounge_mobile/repositories/appointment_repository.dart';

class ManageAppointementBloc
    extends Bloc<ManageAppointementEvent, ManageAppointementState> {
  final AppointmentRepository appointmentRepo;
  final int tutoratId;

  ManageAppointementBloc(
      {required this.appointmentRepo, required this.tutoratId})
      : super(ManageAppointementInitial());

  _submitAppointement(
      int tutoratId, String start, String end, String location) async {
    emit(ManageAppointementLoading());
    bool result = await appointmentRepo.askAppointement(
        tutoratId: tutoratId, start: start, end: end, location: location);
    if (result) {
      emit(ManageAppointementSuccess());
    } else {
      emit(ManageAppointementFailed());
    }
  }
}
