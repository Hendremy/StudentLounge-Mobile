import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_events.dart';
import 'package:studentlounge_mobile/blocs/app/app_state.dart';
import 'package:studentlounge_mobile/models/app_user.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(AppState(user: AppUser.empty())) {
    on<UserAuthenticated>((event, emit) {
      emit(AppState(user: event.user));
    });

    on<UserSignedOff>((event, emit) {
      emit(AppState(user: AppUser.empty()));
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
