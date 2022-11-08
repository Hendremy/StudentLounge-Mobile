import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final int typeOfConnexion;

  const LoginButtonPressed({
    required this.username,
    required this.password,
    required this.typeOfConnexion
  });

  @override
  List<Object> get props => [username, password, typeOfConnexion];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

