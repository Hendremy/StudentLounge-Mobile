// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgendaDateEvent {
  late String id;
  late String label;
  late String description;
  late String location;
  late String summary;
  late DateTime startHour;
  late DateTime endHour;
  late DateTime date;

  AgendaDateEvent(
      {required this.id,
      required this.label,
      required this.description,
      required this.location,
      required this.summary,
      required this.startHour,
      required this.endHour,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'description': description,
      'location': location,
      'summary': summary,
      'startHour': startHour.millisecondsSinceEpoch,
      'endHour': endHour.millisecondsSinceEpoch,
      'date': date.millisecondsSinceEpoch,
    };
  }

  AgendaDateEvent.fromMap(Map<String, dynamic> map) {
    id = map['id'] as String;
    description = map['description'] as String;
    location = map['location'] as String;
    summary = map['summary'] as String;
    startHour = DateTime.parse(map['startHour'] as String);
    endHour = DateTime.parse(map['endHour'] as String);
    date = DateTime.parse(map['date'] as String);
  }
}
