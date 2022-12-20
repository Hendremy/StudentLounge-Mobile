import 'package:studentlounge_mobile/models/appointment.dart';

abstract class ScheduleEvent {}

class RetryLoadSchedule extends ScheduleEvent {}

class ScheduleAppointmentsLoaded extends ScheduleEvent {
  final List<Appointment> appointments;

  ScheduleAppointmentsLoaded({required this.appointments});
}
