import 'package:studentlounge_mobile/models/agenda_event.dart';

class Agenda {
  final String name;
  final List<AgendaEvent> events;

  Agenda({required this.events, required this.name});
}