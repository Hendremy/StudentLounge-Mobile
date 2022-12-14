import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/schedule_date_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleDataSource extends CalendarDataSource {
  final List<Color?> agendaColors = [
    Colors.blue[600],
    Colors.red[600],
    Colors.purple[600],
    Colors.amber[600]
  ];
  late List<ScheduleDateEvent> events;

  ScheduleDataSource(List<Agenda> agendas) {
    int colorIndex = 0;
    events = [];
    for (Agenda agenda in agendas) {
      var scheduleDates = _convertFromAgenda(agenda, agendaColors[colorIndex]!);
      colorIndex = (colorIndex + 1) % agendaColors.length;
      events.addAll(scheduleDates);
    }
  }

  List<ScheduleDateEvent> _convertFromAgenda(Agenda agenda, Color color) {
    var events =
        agenda.events.map((e) => ScheduleDateEvent.fromAgendaEvent(e, color));
    return List<ScheduleDateEvent>.of(events);
  }

  @override
  DateTime getStartTime(int index) {
    return events[index].startHour;
  }

  @override
  DateTime getEndTime(int index) {
    return events[index].endHour;
  }

  @override
  String getSubject(int index) {
    return events[index].summary;
  }

  @override
  Color getColor(int index) {
    return events[index].color;
  }

  @override
  bool isAllDay(int index) {
    return events![index].isAllDay;
  }
}
