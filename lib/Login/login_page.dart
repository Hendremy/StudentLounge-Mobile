import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/login/login_events.dart';
import '../authentication/authentication_bloc.dart';
import 'login_form.dart';
import '../authentication/user_repository.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key? key, required this.userRepository})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  late AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(126, 87, 255, 100),
        body: SafeArea(
          child: ListView(
            children: [

              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      //Title
                      const Text(
                        'Student Lounge',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'Gugi',
                        ),
                      ),
                      //Form
                      LoginForm(
                        authenticationBloc: _authenticationBloc,
                        loginBloc: _loginBloc,
                      ),
                      const SizedBox(height: 30),
                      //Google Login
                      SizedBox(
                        width: 280,
                        height: 50,
                        child: FloatingActionButton.extended(
                          onPressed: _onLoginGooglePressed,
                          icon: Image.asset(
                              'assets/images/google.png', width: 30,
                              height: 30),
                          label: Text('Continuer avec Google'),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,),
                      ),
                    ]
                )
            )
        ])
      )
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  _onLoginGooglePressed() {
    _loginBloc.add(const LoginButtonPressed(
        username: "", password: "", typeOfConnexion: 2));
  }
}