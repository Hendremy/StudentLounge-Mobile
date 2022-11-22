import 'package:bloc/bloc.dart';

import 'app_events.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late AppUser user;

  AppBloc() : super(LoggedOff()) {
    on<UserAuthenticated>((event, emit) {
      emit(LoggedIn(user: event.user));
    });
    on<UserSignedOff>((event, emit) {
      emit(LoggedOff());
    });
  }
}

class AppUser {
  final String token;
  //final String username;
  //final String userId;

  const AppUser(this.token/*, this.userId, this.username*/);
}
