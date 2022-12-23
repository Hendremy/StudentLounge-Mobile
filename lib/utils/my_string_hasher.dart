import 'package:crypto/crypto.dart';
import 'dart:convert';

class MyStringHasher {
  static String hashSHA256(String string) {
    var bytes = utf8.encode(string); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
