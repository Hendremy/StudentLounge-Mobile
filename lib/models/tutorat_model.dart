import 'package:equatable/equatable.dart';

class Tutorat extends Equatable {
  late String id;
  late String tutor;
  late String tutored;

  Tutorat({required this.id, required this.tutored, required this.tutor});

  Tutorat.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tutor = map['tutor'];
    tutored = map['tutored'];
  }

  Tutorat.empty() {
    id = "";
    tutor = "";
    tutored = "";
  }

  @override
  List<Object?> get props => [id, tutor, tutored];
}
