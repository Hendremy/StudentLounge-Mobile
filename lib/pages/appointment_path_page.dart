import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class AppointmentPathPage extends StatefulWidget {
  final Appointment appointment;
  const AppointmentPathPage({super.key, required this.appointment});

  @override
  State<AppointmentPathPage> createState() => _AppointmentPathPageState();
}

class _AppointmentPathPageState extends State<AppointmentPathPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: Size.zero,
                child: Text(
                  widget.appointment.summary,
                  style: const TextStyle(color: theme.white),
                )),
            actions: const [],
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Rendez-vous',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: LoadingIndicator());
  }
}
