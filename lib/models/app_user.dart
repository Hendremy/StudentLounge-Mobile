import 'dart:convert';

class AppUser {
  late String token;
  late String fullname;
  late String id;
  late String? image;
  late List<String> roles;

  AppUser(this.id, this.token, this.fullname, this.image);

  AppUser.empty() {
    token = "";
    fullname = "";
    id = "";
    image = null;
    roles = [];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'token': token, 'fullname': fullname, 'image': image, 'roles': jsonEncode(roles)};
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    token = map['token'];
    fullname = map['fullname'];
    image = map['image'];
    roles = _rolesFromList(map['roles']);
  }

  List<String> _rolesFromList(List<dynamic> roles){
    List<String> rolesString = [];
    for(var role in roles){
      String roleString = role as String;
      rolesString.add(roleString);
    }
    return rolesString;
  }
}
