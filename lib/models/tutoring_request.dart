// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studentlounge_mobile/models/tutoring_user.dart';

class TutoringRequest {
  final int id;
  final TutoringUser tutor;
  final TutoringUser tutored;
  final String lesson;

  TutoringRequest({
    required this.id,
    required this.tutor,
    required this.tutored,
    required this.lesson,
  });

  factory TutoringRequest.empty() {
    return TutoringRequest(
        id: -1,
        tutor: TutoringUser.empty(),
        tutored: TutoringUser.empty(),
        lesson: "");
  }

  get isPending {
    return tutor.name.isEmpty;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tutor': tutor.toMap(),
      'tutored': tutored.toMap(),
      'lesson': lesson,
    };
  }

  factory TutoringRequest.fromMap(Map<String, dynamic> map) {
    return TutoringRequest(
      id: map['id'] as int,
      tutor: map['tutor'] != null
          ? TutoringUser.fromMap(map['tutor'] as Map<String, dynamic>)
          : TutoringUser.empty(),
      tutored: TutoringUser.fromMap(map['tutored'] as Map<String, dynamic>),
      lesson: map['lesson'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TutoringRequest.fromJson(String source) =>
      TutoringRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
