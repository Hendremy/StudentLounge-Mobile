import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/appointment_row.dart';
import 'package:studentlounge_mobile/widgets/center_message.dart';

class AppointmentListPage extends StatefulWidget {
  final List<Appointment> appointments;
  const AppointmentListPage({super.key, required this.appointments});

  get isEmpty {
    return appointments.isEmpty;
  }

  @override
  State<AppointmentListPage> createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            actions: const [],
            backgroundColor: theme.primary,
            title: const Text('Rendez-vous',
                style: TextStyle(fontSize: 30, fontFamily: 'Gugi'))),
        body: _renderBody());
  }

  _renderBody() {
    if (widget.isEmpty) {
      return const CenterMessage(text: "Vous n'avez pas de rendez-vous");
    } else {
      return ListView(
          padding: const EdgeInsets.all(8),
          children: <AppointmentRow>[
            for (Appointment apt in widget.appointments)
              AppointmentRow(
                appointment: apt,
                onPressed: onAppointmentClick,
              )
          ]);
    }
  }

  void onAppointmentClick(Appointment apt) {
    Navigator.pushNamed(context, 'appointment', arguments: apt);
  }
}
