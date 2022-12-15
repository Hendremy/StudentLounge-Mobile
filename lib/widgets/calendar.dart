import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/agenda.dart';
import 'package:studentlounge_mobile/models/agenda_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatelessWidget {
  final List<Agenda> agendas;
  const Calendar({super.key, required this.agendas});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
        view: CalendarView.schedule,
        scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 70,
            hideEmptyScheduleWeek: true,
            weekHeaderSettings: WeekHeaderSettings(
                startDateFormat: 'dd MMM ',
                endDateFormat: 'dd MMM, yy',
                height: 50,
                textAlign: TextAlign.center,
                backgroundColor: Colors.red,
                weekTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                )),
            monthHeaderSettings: MonthHeaderSettings(
                monthFormat: 'MMMM, yyyy',
                height: 100,
                textAlign: TextAlign.left,
                backgroundColor: Colors.green,
                monthTextStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.w400))),
        dataSource: ScheduleDataSource(agendas));
  }
}
