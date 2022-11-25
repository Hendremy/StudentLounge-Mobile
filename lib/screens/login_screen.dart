import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_bloc.dart';
import 'package:studentlounge_mobile/blocs/login/login_bloc.dart';
import 'package:studentlounge_mobile/blocs/login/login_events.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  late AppBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<AppBloc>(context);
    _loginBloc = LoginBloc(
        userRepository: context.read<AppAnonymServices>().userRepo,
        appBloc: _appBloc);
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
