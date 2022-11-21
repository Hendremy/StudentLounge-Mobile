import 'package:bloc/bloc.dart';
import 'authentication_events.dart';
import 'authentication_state.dart';
import '../../services/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<AuthenticationSuccess>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.persistToken(event.token);
      emit(AuthenticationAuthenticated());
    });
    // on<LoggedOut>((event, emit) async {
    //   emit(AuthenticationLoading());
    //   await userRepository.deleteToken();
    //   emit(AuthenticationUnauthenticated());
    // });
  }
}
