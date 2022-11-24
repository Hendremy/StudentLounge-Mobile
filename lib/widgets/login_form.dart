import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/login/login_bloc.dart';
import 'package:studentlounge_mobile/blocs/login/login_events.dart';
import 'package:studentlounge_mobile/blocs/login/login_state.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;

  LoginForm({Key? key, required this.loginBloc}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: theme.error,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              const SizedBox(height: 50),

              //email textfield
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primaryDark,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Adresse e-mail',
                          border: InputBorder.none,
                          floatingLabelStyle: TextStyle(color: theme.primary),
                          labelStyle: TextStyle(color: theme.primary)),
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: theme.primary,
                    ),
                  )
                  //controller: _usernameController,
                  ),
              const SizedBox(height: 20),

              //password textfield
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: theme.primaryDark,
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Mot de passe',
                            border: InputBorder.none,
                            floatingLabelStyle: TextStyle(color: theme.primary),
                            labelStyle: TextStyle(color: theme.primary)),
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: theme.primary,
                      ))),
              const SizedBox(height: 20),

              //Sign in button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(38, 18, 146, 100),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    elevation: 5),
                onPressed:
                    state is! LoginLoading ? _onLoginButtonPressed : null,
                child: const Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 25, fontFamily: 'Gugi'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
        authType: AuthType.Basic));
  }
}
