import 'package:flutter/cupertino.dart';

class UserRepository {
  Duration duration  = const Duration(seconds: 1);

  Future<String> authenticate({
    required String username,
    required String password,
  }) async {
    await Future.delayed(duration);
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(duration);
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(duration);
  }

  Future<bool> hasToken() async {
    await Future.delayed(duration);
    return false;
  }
}