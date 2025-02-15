// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studentlounge_mobile/models/app_user.dart';

class AppState {
  final AppUser user;

  AppState({required this.user});

  bool get isLoggedIn => user.id.isNotEmpty;

  String get fullame => user.fullname;
  List<String> get roles => user.roles;
  String get token => user.token;
  String? get image => user.image;
  String get id => user.id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(user: AppUser.fromMap(map['user'] as Map<String, dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) =>
      AppState.fromMap(json.decode(source) as Map<String, dynamic>);
}
