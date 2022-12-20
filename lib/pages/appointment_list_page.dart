import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentlounge_mobile/models/appointment.dart';

class AppointmentListPage extends StatefulWidget {
  final List<Appointment> appointments;
  const AppointmentListPage({super.key, required this.appointments});

  @override
  State<AppointmentListPage> createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
