// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:studentlounge_mobile/models/agenda_date_event.dart';

class ScheduleDateEvent {
  final DateTime startHour;
  final DateTime endHour;
  final String summary;
  final Color color;
  final bool isAllDay;

  ScheduleDateEvent({
    required this.startHour,
    required this.endHour,
    required this.summary,
    required this.color,
    required this.isAllDay,
  });

  factory ScheduleDateEvent.fromAgendaEvent(
      AgendaDateEvent agendaEvent, Color color) {
    return ScheduleDateEvent(
        startHour: agendaEvent.startHour,
        endHour: agendaEvent.endHour,
        summary: agendaEvent.summary,
        color: color,
        isAllDay: false);
  }
}
