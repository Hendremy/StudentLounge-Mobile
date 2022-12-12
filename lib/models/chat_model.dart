import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  late int id;
  late String name;
  late String? image;

  Chat({required this.id, required this.name, this.image});

  Chat.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
  }

  Chat.empty() {
    name = "";
    image = null;
    id = -1;
  }

  @override
  List<Object?> get props => [id, name, image];
}
