import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/agenda_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class Calendar extends StatelessWidget {
  final List<Agenda> agendas;
  const Calendar({super.key, required this.agendas});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
        view: CalendarView.schedule,
        timeZone: "Central Europe Standard Time",
        scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 70,
            hideEmptyScheduleWeek: true,
            weekHeaderSettings: WeekHeaderSettings(
                height: 50,
                textAlign: TextAlign.center,
                backgroundColor: theme.secondary,
                weekTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                )),
            monthHeaderSettings: MonthHeaderSettings(
                monthFormat: 'MMMM, yyyy',
                height: 50,
                textAlign: TextAlign.center,
                backgroundColor: theme.primaryDark,
                monthTextStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15))),
        dataSource: ScheduleDataSource(agendas));
  }
}
