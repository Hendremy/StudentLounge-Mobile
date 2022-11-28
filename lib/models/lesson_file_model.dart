class LessonFile {
  late String id;
  late FileType type;
  late String name;
  late String user;
  late DateTime date;

  LessonFile({
    required this.id,
    required this.type,
    required this.name,
    required this.user,
    required this.date,
  });

  LessonFile.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = _convertFileType(map['type']);
    name = map['name'];
    user = map['user'];
    date = DateTime.parse(map['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.value,
      'name': name,
      'user': user,
      'date': date.toString()
    };
  }

  _convertFileType(int id) {}
}

enum FileType {
  notes(1),
  summary(2);

  final int value;
  const FileType(this.value);
}
