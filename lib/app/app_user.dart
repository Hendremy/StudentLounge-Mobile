import 'dart:convert';

class AppUser {
  late String token;
  late String fullname;
  late String userId;
  late String? image;

  AppUser(this.userId, this.token, this.fullname, this.image);

  AppUser.empty(){
    token = "";
    fullname = "";
    userId = "";
    image = null;
  }

  AppUser.fromJson(String json) {
    dynamic jsonUser = jsonDecode(json);
    userId = jsonUser['id'];
    token = jsonUser['token'];
    fullname = jsonUser['fullname'];
    image = jsonUser['image'];
  }

  Map<String, dynamic> toMap() {
    return {'id': userId, 'token': token, 'fullname': fullname, 'image': image};
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    userId = map['id'];
    token = map['token'];
    fullname = map['fullname'];
    image = map['image'];
  }
}
