import 'package:bloc/bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../Authentication/AuthenticationBloc.dart';
import '../Authentication/AuthenticationEvents.dart';
import 'LoginEvents.dart';
import 'LoginState.dart';
import '../Authentication/UserRepository.dart';

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
        if(event.typeOfConnexion == 1){
          await basicLogin(event, emit);
        }else if(event.typeOfConnexion == 2){
          await googleLogin(emit);
        }else if(event.typeOfConnexion == 3){
          await facebookLogin(event, emit);
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
      emit(const LoginFailure(error: "non authentifié"));
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
      emit(LoginFailure(error: response.statusCode.toString()));
    }
  }

  facebookLogin(LoginButtonPressed event, Emitter<LoginState> emit) async {
    var auth = await userRepository.facebookSignIn();
    var token = auth?.accessToken;
    if(token != null) {
      authenticationBloc.add(LoggedIn(token: token.token));
      emit(LoginInitial());
    } else{
      emit(const LoginFailure(error: "non authentifié"));
    }
  }
}