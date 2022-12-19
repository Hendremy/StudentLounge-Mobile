// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studentlounge_mobile/models/validated_tutoring.dart';

class Appointment {
  final int id;
  final ValidatedTutoring tutoring;
  final DateTime start;
  final DateTime end;
  final String location;

  Appointment({
    required this.id,
    required this.tutoring,
    required this.start,
    required this.end,
    required this.location,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as int,
      tutoring:
          ValidatedTutoring.fromMap(map['tutoring'] as Map<String, dynamic>),
      start: DateTime.parse(map['start'] as String).toUtc(),
      end: DateTime.parse(map['start'] as String).toUtc(),
      location: map['location'] as String,
    );
  }

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);
}
