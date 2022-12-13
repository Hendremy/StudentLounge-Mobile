import 'dart:async';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';

abstract class UserRepository extends ApiService {
  UserRepository({required super.apiUrl, required super.controller});

  Future<AppUser?> authenticate(
      {required String username, required String password});

  Future<AppUser?> authenticateWithGoogle();
}

class AppUserRepository extends UserRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AppUserRepository({required super.apiUrl, required super.controller});

  @override
  Future<AppUser?> authenticate({
    required String username,
    required String password,
  }) async {
    var body = jsonEncode({'username': username, 'password': password});
    return await _retrieveUser('Login', body);
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
        return await _retrieveUser('External', body);
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<AppUser?> _retrieveUser(String action, String body) async {
    http.Response response =
        await http.post(Uri.parse('$controllerUrl/$action'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body);
    if (response.statusCode == 200) {
      return AppUser.fromMap(jsonDecode(response.body));
    }
    return null;
  }
}
