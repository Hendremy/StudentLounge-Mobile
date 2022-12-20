import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/agenda_date_event.dart';
import 'package:studentlounge_mobile/models/api_exception.dart';

abstract class ScheduleState {
  final List<Agenda> agendas;

  ScheduleState({required this.agendas});
}

class ScheduleInitial extends ScheduleState {
  ScheduleInitial() : super(agendas: []);
}

class ScheduleLoadSuccess extends ScheduleState {
  ScheduleLoadSuccess({required super.agendas});
}

class ScheduleLoadFailed extends ScheduleState {
  final String message;

  ScheduleLoadFailed({required this.message}) : super(agendas: []);
}

class ScheduleLoading extends ScheduleState {
  ScheduleLoading() : super(agendas: []);
}
