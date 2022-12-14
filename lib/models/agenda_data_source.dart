import 'dart:ui';

import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/schedule_date_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleDataSource extends CalendarDataSource {
  late List<ScheduleDateEvent> events;

  ScheduleDataSource(List<Agenda> agendas) {
    events = [];
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
