import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_bloc.dart';
import 'package:studentlounge_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/pages/appointment_list_page.dart';
import 'package:studentlounge_mobile/pages/appointment_path_page.dart';
import 'package:studentlounge_mobile/pages/schedule_page.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  late AppStudentServices _services;

  @override
  void initState() {
    _services = context.read<AppStudentServices>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ScheduleBloc(scheduleRepository: _services.scheduleRepo)),
          BlocProvider(
              create: (context) => AppointmentListBloc(
                  appointmentRepo: _services.appointmentRepository)),
        ],
        child: Navigator(onGenerateRoute: ((settings) {
          Widget page = const SchedulePage();
          switch (settings.name) {
            case 'appointment':
              Appointment apt = settings.arguments as Appointment;
              page = BlocProvider(
                create: (context) => AppointmentPathBloc(
                    appointment: apt,
                    directionsRepository: _services.directionsRepository,
                    locationRepository: _services.locationRepository),
                child: AppointmentPathPage(appointment: apt),
              );
              break;
            case 'apptList':
              List<Appointment> apts = settings.arguments as List<Appointment>;
              page = AppointmentListPage(appointments: apts);
              break;
            default:
              break;
          }
          return MaterialPageRoute(builder: (_) => page);
        })));
  }
}
