import 'package:studentlounge_mobile/models/agenda_event.dart';

abstract class ScheduleState {

}

class ScheduleInitial extends ScheduleState{}

class ScheduleLoaded extends ScheduleState {
  final List<AgendaEvent> agendaEvents;

  ScheduleLoaded({required this.agendaEvents});
}

class ScheduleLoadFailed extends ScheduleState {

}

class ScheduleLoading extends ScheduleState {

}