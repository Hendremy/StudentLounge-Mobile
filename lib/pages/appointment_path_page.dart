import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentlounge_mobile/models/appointment.dart';

class AppointmentPathPage extends StatefulWidget {
  final Appointment appointment;
  const AppointmentPathPage({super.key, required this.appointment});

  @override
  State<AppointmentPathPage> createState() => _AppointmentPathPageState();
}

class _AppointmentPathPageState extends State<AppointmentPathPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
