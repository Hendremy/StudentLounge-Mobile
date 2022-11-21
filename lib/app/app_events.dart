import 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent([List props = const []]);
}

class AuthenticationSuccess extends AppEvent {
  final AppUser user;

  AuthenticationSuccess({required this.user});
}

class UserSignedOff extends AppEvent {}
