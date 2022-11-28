import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  late String name;
  late String id;

  Lesson({required this.id, required this.name});

  Lesson.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Lesson.empty() {
    name = "";
    id = "";
  }

  @override
  List<Object?> get props => [id, name];
}
