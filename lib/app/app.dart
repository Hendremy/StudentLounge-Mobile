import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/app/app_state.dart';
import 'package:studentlounge_mobile/services/user_repository.dart';
import '../login/login_page.dart';
import '../page/splash_page.dart';
import '../session/session_page.dart';
import 'app_bloc.dart';

class App extends StatefulWidget {
  //App({Key? key}): super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
        child: MaterialApp(
            home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          if (state is LoggedOff) {
            return LoginPage(userRepository: _userRepo);
            // return LoginPage(userRepository: _userRepo);
          } else if (state is LoggedIn) {
            return SessionPage();
          }
          return SplashPage();
        })));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
