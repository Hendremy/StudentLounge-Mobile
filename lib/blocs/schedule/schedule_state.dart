import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/agenda_date_event.dart';
import 'package:studentlounge_mobile/models/api_error.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadSuccess extends ScheduleState {
  final List<Agenda> agendas;

  ScheduleLoadSuccess({required this.agendas});
}

class ScheduleLoadFailed extends ScheduleState {
  final ApiException error;

  ScheduleLoadFailed({required this.error});
}

class ScheduleLoading extends ScheduleState {}
