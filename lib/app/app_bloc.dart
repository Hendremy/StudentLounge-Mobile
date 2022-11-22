import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:studentlounge_mobile/services/authentication_storage.dart';

import 'app_events.dart';
import 'app_state.dart';
import 'app_user.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  final AuthenticationStorage authStorage;
  late AppUser user;

  AppBloc(this.authStorage) : super(AppState()) {
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
