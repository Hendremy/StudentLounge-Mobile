// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:studentlounge_mobile/models/validated_tutoring.dart';
import 'package:studentlounge_mobile/utils/my_date_formatter.dart';

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

  String get date {
    return MyDateFormatter.formatDateYMMMD(start);
  }

  String get startHour {
    return MyDateFormatter.formatHours(start);
  }

  String get endHour {
    return MyDateFormatter.formatHours(end);
  }

  String get summary {
    return "${tutoring.lesson} - ${tutoring.tutor.name} & ${tutoring.tutored.name}";
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as int,
      tutoring:
          ValidatedTutoring.fromMap(map['tutoring'] as Map<String, dynamic>),
      start: DateTime.parse(map['start'] as String).toUtc(),
      end: DateTime.parse(map['end'] as String).toUtc(),
      location: map['location'] as String,
    );
  }

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);
}
