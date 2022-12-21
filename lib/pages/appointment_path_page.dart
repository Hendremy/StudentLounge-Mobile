import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_state.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/repositories/location_repository.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/google_map_path.dart';

class AppointmentPathPage extends StatefulWidget {
  final Appointment appointment;
  const AppointmentPathPage({super.key, required this.appointment});

  @override
  State<AppointmentPathPage> createState() => _AppointmentPathPageState();
}

class _AppointmentPathPageState extends State<AppointmentPathPage> {
  late LocationRepository locationService;

  @override
  void initState() {
    locationService = context.read<AppStudentServices>().locationRepository;
    Position pos = super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: Size.zero,
                child: Text(
                  "${widget.appointment.date} de ${widget.appointment.startHour} à ${widget.appointment.endHour} \n ${widget.appointment.location}",
                  style: const TextStyle(fontSize: 12, color: theme.white),
                )),
            actions: const [],
            backgroundColor: theme.primary,
            title: Center(
                child: Text(widget.appointment.summary,
                    style: const TextStyle(fontSize: 20, fontFamily: 'Gugi')))),
        body: BlocBuilder<AppointmentPathBloc, AppointmentPathState>(
          builder: (context, state) {
            if (state is AppointmentPathLoaded)
              return GoogleMapPath({path: state.path});
          },
        ));
  }
}
