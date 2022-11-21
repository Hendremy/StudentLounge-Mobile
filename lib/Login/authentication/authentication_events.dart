import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationEvent {
  final String token;

  AuthenticationSuccess({required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => [token];
}

//Evenement de déconnexion devrait devenir de la Session
// class LoggedOut extends AuthenticationEvent {
//   @override
//   String toString() => 'LoggedOut';

//   @override
//   List<Object> get props => [];
// }
