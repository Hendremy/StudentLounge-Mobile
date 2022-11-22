import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  var storage = const FlutterSecureStorage();

  var baseUrl = "https://porthos-intra.cg.helmo.be/e190449";
  // var baseUrl = "https://localhost:44321";

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  Duration duration = const Duration(seconds: 1);

  Future<dynamic> authenticate({
    required String username,
    required String password,
  }) async {
    var body = jsonEncode({'username': username, 'password': password});
    http.Response response = await http.post(Uri.parse('$baseUrl/Auth/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response;
  }

  Future<void> deleteToken() async {
    await Future.delayed(duration);
  }

  Future<void> persistToken(String token) async {
    storage.write(key: "jwt", value: token);
  }

  Future<bool> hasToken() async {
    return storage.containsKey(key: "jwt");
  }

  Future<GoogleSignInAuthentication?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      //TODO: JWT Google ok, mais il faut appeler le backend pour obtenir le JWT de notre application
      // (Appel à url/ExtAuth)
      if (googleSignInAccount != null) {
        return googleSignInAccount.authentication;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
