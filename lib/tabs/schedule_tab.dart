import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/pages/schedule_page.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Horaire',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: const SchedulePage());
  }
}
