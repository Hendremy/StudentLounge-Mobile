class LessonFile {
  late String id;
  late FileType type;
  late String name;
  late String user;
  late DateTime date;
  late String contentType;

  LessonFile(
      {required this.id,
      required this.type,
      required this.name,
      required this.user,
      required this.date,
      required this.contentType});

  LessonFile.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = _convertFileType(map['type']);
    name = map['name'];
    user = map['user'];
    contentType = map['contentType'];
    date = DateTime.parse(map['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.value,
      'name': name,
      'user': user,
      'contentType': contentType,
      'date': date.toString()
    };
  }

  FileType _convertFileType(int id) {
    switch (id) {
      case 1:
        return FileType.notes;
      default:
        return FileType.summary;
    }
  }
}

enum FileType {
  notes(1),
  summary(2);

  final int value;
  const FileType(this.value);
}
