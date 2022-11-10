import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserRepository {
  var storage = const FlutterSecureStorage();
  //var baseUrl = "http://porthos-intra.cg.helmo.be/e190449";
  var baseUrl = "https://localhost:44321";

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  Duration duration  = const Duration(seconds: 1);

  Future<http.Response> authenticate({
    required String username,
    required String password,
  }) async {
    var body = jsonEncode({'username':username, 'password':password});
    http.Response response = await http.post(
        Uri.parse('$baseUrl/Auth/Login'),
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
    storage.write(key:"jwt", value:token);
  }

  Future<bool> hasToken() async {
    await Future.delayed(duration);
    return false;
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

  Future<FacebookLoginResult?> facebookSignIn() async {
    try {
      final res = await _facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
          return res;
          break;
        case FacebookLoginStatus.cancel:
        // User cancel log in
          print('Log in cancelled');
          return null;
          break;
        case FacebookLoginStatus.error:
        // Log in failed
          print('Error while log in: ${res.error}');
          return null;
          break;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}