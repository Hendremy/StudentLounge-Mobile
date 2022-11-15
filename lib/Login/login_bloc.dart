import 'package:bloc/bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../Authentication/authentication_bloc.dart';
import '../Authentication/authentication_events.dart';
import 'login_events.dart';
import 'login_state.dart';
import '../Authentication/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : super(LoginInitial()){
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        switch(event.typeOfConnexion){
          case 1:
            await basicLogin(event, emit);
            break;
          case 2:
            await googleLogin(emit);
            break;
        }
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }

  Future<void> googleLogin(Emitter<LoginState> emit) async {
    var auth = await userRepository.googleSignIn();
    var token = auth?.accessToken;
    if(token != null) {
      authenticationBloc.add(LoggedIn(token: token));
      emit(LoginInitial());
    } else{
      emit(const LoginFailure(error: "Non authentifié"));
    }
  }

  Future<void> basicLogin(LoginButtonPressed event, Emitter<LoginState> emit) async {
    final response = await userRepository.authenticate(
      username: event.username,
      password: event.password,
    );

    if(response.statusCode == 200) {
      authenticationBloc.add(LoggedIn(token: response.body));
      emit(LoginInitial());
    } else{
      emit(const LoginFailure(error: "Non authentifié"));
    }
  }
}