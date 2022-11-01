import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  var baseUrl = "http://porthos.intra-cg/e190449/";
  Duration duration  = const Duration(seconds: 1);

  Future<http.Response> authenticate({
    required String username,
    required String password,
  }) async {
    var body = jsonEncode({'username':username, 'password':password});
    http.Response response = await http.post(
        Uri.parse("$baseUrl/LogIn/LogIn"),
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
    await Future.delayed(duration);
  }

  Future<bool> hasToken() async {
    await Future.delayed(duration);
    return false;
  }
}