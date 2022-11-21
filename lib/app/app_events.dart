import 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent([List props = const []]);
}

class UserAuthenticated extends AppEvent {
  final AppUser user;

  UserAuthenticated({required this.user});
}

class UserSignedOff extends AppEvent {}
