import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentlounge_mobile/models/appointment.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class AppointmentRow extends StatelessWidget {
  final Appointment appointment;
  final Function(Appointment appointment) onPressed;

  const AppointmentRow(
      {super.key, required this.appointment, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: theme.primary,
        child: ListTile(
          onTap: () => onPressed(appointment),
          trailing: const Icon(
            Icons.pin_drop,
            size: 40,
            color: theme.white,
          ),
          title: Text(appointment.summary,
              style: const TextStyle(color: theme.white, fontSize: 15)),
          subtitle: Text(
              "${appointment.date} de ${appointment.startHour} à ${appointment.endHour} \n ${appointment.location}",
              style: const TextStyle(color: theme.white, fontSize: 15)),
        ));
  }
}
