import 'package:bloc/bloc.dart';
import 'AuthenticationBloc.dart';
import 'AuthenticationEvents.dart';
import 'LoginEvents.dart';
import 'LoginState.dart';
import 'UserRepository.dart';

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
        final response = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        authenticationBloc.add(LoggedIn(token: response.body));
        if(response.statusCode == 200) {
          emit(LoginInitial());
        } else{
          emit(LoginFailure(error: response.statusCode.toString()));
        }
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}