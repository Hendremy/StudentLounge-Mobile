import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/login/login_events.dart';
import '../app/app_bloc.dart';
import '../app/app_events.dart';
import 'login_events.dart';
import 'login_state.dart';
import '../services/authentication_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AppBloc appBloc;

  LoginBloc({
    required this.userRepository,
    required this.appBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        switch (event.authType) {
          case AuthType.Basic:
            await basicLogin(event, emit);
            break;
          case AuthType.Google:
            await googleLogin(emit);
            break;
        }
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }

  Future<void> googleLogin(Emitter<LoginState> emit) async {
    dynamic userInfo = await userRepository.authenticateWithGoogle();
    if (userInfo != null) {
      appBloc.add(UserAuthenticated(user: userInfo));
      emit(LoginInitial());
    } else {
      emit(const LoginFailure(error: "Non authentifié"));
    }
  }

  Future<void> basicLogin(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    final userInfo = await userRepository.authenticate(
      username: event.username,
      password: event.password,
    );

    if (userInfo != null) {
      appBloc.add(UserAuthenticated(user: userInfo));
      emit(LoginInitial());
    } else {
      emit(const LoginFailure(error: "Non authentifié"));
    }
  }
}
