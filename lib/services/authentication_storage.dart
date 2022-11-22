import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:studentlounge_mobile/app/app_bloc.dart';
import 'package:studentlounge_mobile/app/app_user.dart';

abstract class AuthenticationStorage {
  Future<void> deleteUser();
  Future<void> persistUser(AppUser user);
  Future<bool> hasUser();
  Future<AppUser?> getUser();
}

class UserStorage extends AuthenticationStorage {
  var storage = const FlutterSecureStorage();

  @override
  Future<void> deleteUser() async {
    storage.delete(key: "user");
  }

  @override
  Future<void> persistUser(AppUser user) async {
    storage.write(key: "user", value: jsonEncode(user));
  }

  @override
  Future<bool> hasUser() async {
    return storage.containsKey(key: "user");
  }

  @override
  Future<AppUser?> getUser() async {
    String? userJson = await storage.read(key: "user");
    if (userJson != null) {
      return AppUser.fromJson(userJson);
    }
    return null;
  }
}
