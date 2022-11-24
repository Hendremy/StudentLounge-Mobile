import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final AuthType authType;

  const LoginButtonPressed(
      {required this.username, required this.password, required this.authType});

  @override
  List<Object> get props => [username, password, authType];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

enum AuthType { Google, Basic }
