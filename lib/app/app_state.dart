import 'app_bloc.dart';

abstract class AppState {}

class LoggedIn extends AppState {
  final AppUser user;

  LoggedIn({required this.user});
}

class LoggedOff extends AppState {}
