import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:studentlounge_mobile/app/app_bloc.dart';

class UserRepository {
  var storage = const FlutterSecureStorage();

  var baseUrl = "https://porthos-intra.cg.helmo.be/e190449";
  // var baseUrl = "https://localhost:44321";

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  Duration duration = const Duration(seconds: 1);

  Future<dynamic> authenticate({ required String username, required String password,}) async {
    var body = jsonEncode({'username': username, 'password': password});
    return await retrieveUser('Auth/Login', body);
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

  Future<dynamic> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication? auth = await googleSignInAccount.authentication;
        dynamic token = auth.accessToken;
        var body = jsonEncode({'provider': 'Google', 'token': token});
        return await retrieveUser('Auth/External', body);
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<dynamic> retrieveUser(String methodUrl, String body) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/$methodUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if(response.statusCode == 200){
      dynamic user = jsonDecode(response.body);
      return AppUser(user['userid'], user['token'], user['fullname'], user['image']);
    }
    return null;
  }
}
