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
<<<<<<< HEAD
  //var baseUrl = "http://porthos-intra.cg.helmo.be/e190449";
  var baseUrl = "https://localhost:44321";

=======
  var baseUrl = "https://porthos-intra.cg.helmo.be/e190449";
>>>>>>> ac7955989ae753f16802945c2cea4803980eea9a
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  Duration duration  = const Duration(seconds: 1);

  Future<dynamic> authenticate({
    required String username,
    required String password,
  }) async {
<<<<<<< HEAD
    var body = jsonEncode({'username':username, 'password':password});
    http.Response response = await http.post(
        Uri.parse('$baseUrl/Auth/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response;
=======
    var body = jsonEncode({"username":username, "password":password});
    return await http.post(
      Uri.parse('$baseUrl/Auth/Login'),
      headers: {"Content-Type": "application/json"},
      body : body,
    );
>>>>>>> ac7955989ae753f16802945c2cea4803980eea9a
  }

  Future<void> deleteToken() async {
    await Future.delayed(duration);
  }

  Future<void> persistToken(String token) async {
    storage.write(key:"jwt", value:token);
  }

  Future<bool> hasToken() async {
    return storage.containsKey(key: "jwt");
  }

  Future<GoogleSignInAuthentication?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        return googleSignInAccount.authentication;
      }else{
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}