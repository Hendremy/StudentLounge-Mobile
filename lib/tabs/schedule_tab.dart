import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:studentlounge_mobile/pages/agenda_page.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(
          scheduleRepository: context.read<AppStudentServices>().scheduleRepo),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: theme.primary,
              title: const Center(
                  child: Text('Horaire',
                      style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
          body: const SchedulePage()),
    );
  }
}
