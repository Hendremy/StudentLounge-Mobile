import 'dart:convert';

class AppUser {
  late String token;
  late String fullname;
  late String id;
  late String? image;

  AppUser(this.id, this.token, this.fullname, this.image);

  AppUser.empty() {
    token = "";
    fullname = "";
    id = "";
    image = null;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'token': token, 'fullname': fullname, 'image': image};
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    token = map['token'];
    fullname = map['fullname'];
    image = map['image'];
  }
}
