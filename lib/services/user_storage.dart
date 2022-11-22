import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  var storage = const FlutterSecureStorage();

  Future<void> deleteToken() async {
    storage.delete(key: "jwt");
  }

  Future<void> persistToken(String token) async {
    storage.write(key: "jwt", value: token);
  }

  Future<bool> hasToken() async {
    return storage.containsKey(key: "jwt");
  }
}