import 'package:studentlounge_mobile/models/api_exception.dart';
import 'package:studentlounge_mobile/models/appointment.dart';

abstract class AppointmentListState {}

class AppointmentListInitial extends AppointmentListState {}

class AppointmentListLoaded extends AppointmentListState {
  final List<Appointment> appointments;

  AppointmentListLoaded({required this.appointments});
}

class AppointmentListLoadFailed extends AppointmentListState {
  final Exception exception;

  AppointmentListLoadFailed({required this.exception});
}

class AppointmentListLoading extends AppointmentListState {}

class AppointmentListError extends AppointmentListState {}
