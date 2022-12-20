import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_events.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_state.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/widgets/calendar.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/show_appointments_button.dart';

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
    return Scaffold(
        appBar: AppBar(
            actions: const [ShowAppointmentsButton()],
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Horaire',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            return _renderBody(state);
          },
        ));
  }

  _renderBody(state) {
    if (state is ScheduleLoadSuccess) {
      return Calendar(
        agendas: state.agendas,
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
