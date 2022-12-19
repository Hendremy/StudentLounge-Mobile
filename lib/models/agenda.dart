// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studentlounge_mobile/models/agenda_date_event.dart';

class Agenda {
  final int id;
  final String name;
  final List<AgendaDateEvent> events;

  Agenda({required this.id, required this.events, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'events': events.map((e) => e.toMap()).toList(),
    };
  }

  factory Agenda.fromMap(Map<String, dynamic> map) {
    return Agenda(
      id: map['id'] as int,
      name: map['name'] as String,
      events: List<AgendaDateEvent>.from(
        (map['agendaEvents'] as List<dynamic>).map<AgendaDateEvent>(
          (e) => AgendaDateEvent.fromMap(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
