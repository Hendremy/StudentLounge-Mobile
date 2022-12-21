import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_events.dart';
import 'package:studentlounge_mobile/blocs/appointment_path/appointment_path_state.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/google_map_path.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

class AppointmentPathPage extends StatefulWidget {
  final Appointment appointment;
  const AppointmentPathPage({super.key, required this.appointment});

  @override
  State<AppointmentPathPage> createState() => _AppointmentPathPageState();
}

class _AppointmentPathPageState extends State<AppointmentPathPage> {
  late AppointmentPathBloc appointmentPathBloc;

  @override
  void initState() {
    appointmentPathBloc = BlocProvider.of<AppointmentPathBloc>(context);
    super.initState();
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
            if (state is AppointmentPathLoaded) {
              return GoogleMapPath(path: state.path);
            } else if (state is AppointmentPathLoading) {
              return LoadingIndicator();
            } else {
              return RetryMessage(
                  text: 'Erreur lors de la récupération du chemin',
                  retry: _retryLoadPath);
            }
          },
        ));
  }

  _retryLoadPath() {
    appointmentPathBloc.add(AppointmentPathRetryLoad());
  }
}
