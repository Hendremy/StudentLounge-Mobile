import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/agenda_date_event.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadSuccess extends ScheduleState {
  final List<Agenda> agendas;

  ScheduleLoadSuccess({required this.agendas});
}

class ScheduleLoadFailed extends ScheduleState {
  final String message;

  ScheduleLoadFailed({required this.message});
}

class ScheduleLoading extends ScheduleState {}
