import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Horaire',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: Center(child: Text('Horaire ')));
  }
}
