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

  ScheduleDataSource(List<Agenda> agendas) {
    int colorIndex = 0;
    appointments = [];
    for (Agenda agenda in agendas) {
      var scheduleDates = _convertFromAgenda(agenda, agendaColors[colorIndex]!);
      colorIndex = (colorIndex + 1) % agendaColors.length;
      appointments?.addAll(scheduleDates);
    }
  }

  List<ScheduleDateEvent> _convertFromAgenda(Agenda agenda, Color color) {
    var events =
        agenda.events.map((e) => ScheduleDateEvent.fromAgendaEvent(e, color));
    return List<ScheduleDateEvent>.of(events);
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startHour;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endHour;
  }

  @override
  String getSubject(int index) {
    return appointments![index].summary;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
