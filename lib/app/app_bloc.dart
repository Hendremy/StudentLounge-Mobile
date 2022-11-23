import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app_events.dart';
import 'app_state.dart';
import 'app_user.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  late AppUser user;

  AppBloc() : super(AppState()) {
    on<UserAuthenticated>((event, emit) {
      emit(AppState(user: event.user));
    });

    on<UserSignedOff>((event, emit) {
      emit(AppState());
    });
  }

  @override
  AppState fromJson(Map<String, dynamic> json) {
    return AppState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toMap();
  }
}
