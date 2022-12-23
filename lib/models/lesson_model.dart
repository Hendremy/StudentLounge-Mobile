// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:studentlounge_mobile/models/tutoring_request.dart';

class Lesson extends Equatable {
  final String name;
  final String id;
  final TutoringRequest tutoring;

  Lesson({required this.id, required this.name, required this.tutoring});

  factory Lesson.empty() {
    return Lesson(name: "", id: "", tutoring: TutoringRequest.empty());
  }

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'tutoring': tutoring.toMap(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      name: map['name'] as String,
      id: map['id'] as String,
      tutoring: map['tutoring'] != null
          ? TutoringRequest.fromMap(map['tutoring'] as Map<String, dynamic>)
          : TutoringRequest.empty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);
}
