class Lesson {
  late String name;
  late int id;

  Lesson({required this.id, required this.name});

  Lesson.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
