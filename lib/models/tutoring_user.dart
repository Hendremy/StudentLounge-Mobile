import 'dart:convert';

class TutoringUser {
  final String name;
  final String image;
  TutoringUser({
    required this.name,
    required this.image,
  });

  factory TutoringUser.empty() {
    return TutoringUser(name: "", image: "");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory TutoringUser.fromMap(Map<String, dynamic> map) {
    return TutoringUser(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TutoringUser.fromJson(String source) =>
      TutoringUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
