import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/repositories/appointment_repository.dart';

import 'appointement_state.dart';

class AppointementCubit extends Cubit<AppointementState> {
  final AppointmentRepository appointementRepository;
  AppointementCubit({required this.appointementRepository})
      : super(AskAppointementInitial());

  void askAppointement(int tutoratId) async {
    try {
      emit(AskAppointementSuccess(tutoratId: tutoratId));
    } catch (ex) {
      emit(AskAppointementFailed());
    }
  }

  void submitAppointement(
      int tutoratId, String start, String end, String location) async {}
}
