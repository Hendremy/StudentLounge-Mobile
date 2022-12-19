import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_events.dart';
import 'package:studentlounge_mobile/blocs/manage_appointement/manage_appointement_state.dart';
import 'package:studentlounge_mobile/repositories/appointement_repository.dart';

class ManageAppointementBloc
    extends Bloc<ManageAppointementEvent, ManageAppointementState> {
  final AppointementRepository appointementRepo;
  final int tutoratId;

  ManageAppointementBloc(
      {required this.appointementRepo, required this.tutoratId})
      : super(ManageAppointementInitial());

  _submitAppointement(
      int tutoratId, String start, String end, String location) async {
    emit(ManageAppointementLoading());
    bool result = await appointementRepo.askAppointement(
        tutoratId: tutoratId, start: start, end: end, location: location);
    if (result) {
      emit(ManageAppointementSuccess());
    } else {
      emit(ManageAppointementFailed());
    }
  }
}
