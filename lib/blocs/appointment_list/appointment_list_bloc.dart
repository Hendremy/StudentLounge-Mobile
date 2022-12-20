import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_events.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_state.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/repositories/appointment_repository.dart';

class AppointmentListBloc
    extends Bloc<AppointmentListEvent, AppointmentListState> {
  final AppointmentRepository appointmentRepo;
  AppointmentListBloc({required this.appointmentRepo})
      : super(AppointmentListInitial()) {
    on<AppointmentListRetryLoad>((event, emit) {
      _loadAppointments();
    });

    _loadAppointments();
  }

  _loadAppointments() async {
    emit(AppointmentListLoading());
    try {
      List<Appointment> appointments =
          await appointmentRepo.getUserAppointments();
      emit(AppointmentListLoaded(appointments: appointments));
    } catch (ex) {
      emit(AppointmentListLoadFailed(exception: ex as Exception));
    }
  }
}
