import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_events.dart';
import 'package:studentlounge_mobile/blocs/appointment_list/appointment_list_state.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';

import '../models/appointment.dart';

class ShowAppointmentsButton extends StatefulWidget {
  const ShowAppointmentsButton({super.key});

  @override
  State<ShowAppointmentsButton> createState() => _ShowAppointmentsButtonState();
}

class _ShowAppointmentsButtonState extends State<ShowAppointmentsButton> {
  late AppointmentListBloc appointmentListBloc;

  @override
  void initState() {
    appointmentListBloc = BlocProvider.of<AppointmentListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentListBloc, AppointmentListState>(
      builder: (context, state) {
        if (state is AppointmentListLoaded) {
          return IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              _onShowAppointments(state.appointments);
            },
          );
        } else if (state is AppointmentListLoading) {
          return LoadingIndicator();
        } else {
          return IconButton(
            icon: const Icon(Icons.location_off),
            onPressed: () {
              _onReloadAppointments();
            },
          );
        }
      },
    );
  }

  _onShowAppointments(List<Appointment> appointments) {
    Navigator.pushNamed(context, 'apptList', arguments: appointments);
  }

  _onReloadAppointments() {
    appointmentListBloc.add(AppointmentListRetryLoad());
  }
}
