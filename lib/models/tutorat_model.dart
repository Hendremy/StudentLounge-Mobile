import 'package:equatable/equatable.dart';

class Tutorat extends Equatable {
  late int id;
  late String userName;
  late String? image;
  late String? tutorName;

  Tutorat(
      {required this.id, required this.userName, this.image, this.tutorName});

  Tutorat.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userName = map['username'];
    image = map['userimage'];
    tutorName = map['tutorname'];
  }

  Tutorat.empty() {
    id = -1;
    userName = "";
  }

  @override
  List<Object?> get props => [id, userName, image, tutorName];
}
