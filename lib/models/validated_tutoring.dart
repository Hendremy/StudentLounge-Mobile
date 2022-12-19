import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ValidatedTutoring {
  final int id;
  final String lesson;
  final TutoringUser tutor;
  final TutoringUser tutored;

  ValidatedTutoring({
    required this.id,
    required this.lesson,
    required this.tutor,
    required this.tutored,
  });

  factory ValidatedTutoring.fromMap(Map<String, dynamic> map) {
    return ValidatedTutoring(
      id: map['id'] as int,
      lesson: map['lesson'] as String,
      tutor: TutoringUser.fromMap(map['tutor'] as Map<String, dynamic>),
      tutored: TutoringUser.fromMap(map['tutored'] as Map<String, dynamic>),
    );
  }

  factory ValidatedTutoring.fromJson(String source) =>
      ValidatedTutoring.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TutoringUser {
  final String name;
  final String image;

  TutoringUser({required this.image, required this.name});

  factory TutoringUser.fromMap(Map<String, dynamic> map) {
    return TutoringUser(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  factory TutoringUser.fromJson(String source) =>
      TutoringUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
