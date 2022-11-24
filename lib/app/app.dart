import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:studentlounge_mobile/app/app_state.dart';
import 'package:studentlounge_mobile/services/services_provider.dart';
import '../login/login_page.dart';
import '../session/session_page.dart';
import 'app_bloc.dart';

class App extends StatefulWidget {
  //App({Key? key}): super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppServicesProvider("https://porthos-intra.cg.helmo.be/e190449/"),
      child: BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc(),
          child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state.isLoggedIn) {
              return SessionPage();
            } else {
              return LoginPage();
            }
          }))),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
