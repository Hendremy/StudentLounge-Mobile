import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/app_bloc.dart';
import 'login_events.dart';
import 'login_form.dart';
import '../services/authentication_repository.dart';
import 'login_bloc.dart';
import '../theme.dart' as theme;

class LoginPage extends StatefulWidget {
  final AuthenticationRepository userRepository;

  const LoginPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  late AppBloc _appBloc;

  AuthenticationRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _appBloc = BlocProvider.of<AppBloc>(context);
    _loginBloc = LoginBloc(userRepository: UserRepository(), appBloc: _appBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.primary,
        body: SafeArea(
            child: ListView(children: [
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
                  loginBloc: _loginBloc,
                ),
                const SizedBox(height: 30),
                //Google Login
                SizedBox(
                  width: 280,
                  height: 50,
                  child: FloatingActionButton.extended(
                    onPressed: _onLoginGooglePressed,
                    icon: Image.asset('assets/images/google.png',
                        width: 30, height: 30),
                    label: Text('Continuer avec Google'),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ]))
        ])));
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  _onLoginGooglePressed() {
    _loginBloc.add(const LoginButtonPressed(
        username: "", password: "", authType: AuthType.Google));
  }
}
