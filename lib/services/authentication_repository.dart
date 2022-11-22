import 'dart:async';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:studentlounge_mobile/app/app_user.dart';

abstract class AuthenticationRepository {
  Future<AppUser?> authenticate(
      {required String username, required String password});

  Future<AppUser?> authenticateWithGoogle();
}

class UserRepository extends AuthenticationRepository {
  final baseUrl = "https://porthos-intra.cg.helmo.be/e190449";
  // var baseUrl = "https://localhost:44321";

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  Duration duration = const Duration(seconds: 1);

  @override
  Future<AppUser?> authenticate({
    required String username,
    required String password,
  }) async {
    var body = jsonEncode({'username': username, 'password': password});
    return await _retrieveUser('Auth/Login', body);
  }

  @override
  Future<AppUser?> authenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication? auth =
            await googleSignInAccount.authentication;
        dynamic token = auth.accessToken;
        var body = jsonEncode({'provider': 'Google', 'token': token});
        return await _retrieveUser('Auth/External', body);
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<AppUser?> _retrieveUser(String methodUrl, String body) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/$methodUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      return AppUser.fromJson(response.body);
    }
    return null;
  }
}
