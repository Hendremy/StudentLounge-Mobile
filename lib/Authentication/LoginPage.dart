import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AuthenticationBloc.dart';
import 'LoginForm.dart';
import 'UserRepository.dart';
import 'loginBloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

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
      backgroundColor: const Color.fromRGBO(126,87, 255, 100),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              //Google Login

              //Facebook Login

              //Apple Login
            ]
          )
        )
      )
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}