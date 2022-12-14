import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_events.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_state.dart';
import 'package:studentlounge_mobile/models/agenda_data_source.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late ScheduleBloc scheduleBloc;

  @override
  void initState() {
    scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return _renderBody(state);
      },
    ));
  }

  _renderBody(state) {
    if (state is ScheduleLoadSuccess) {
      return SfCalendar(
        view: CalendarView.schedule,
        dataSource: ScheduleDataSource(state.agendas),
      );
    } else if (state is ScheduleLoading) {
      return LoadingIndicator();
    } else {
      return RetryMessage(
          text: 'Erreur lors du chargement de votre horaire',
          retry: _retryLoad);
    }
  }

  _retryLoad() {
    scheduleBloc.add(RetryLoadSchedule());
  }
}
