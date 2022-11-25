import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:studentlounge_mobile/blocs/app/app_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_state.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/screens/login_screen.dart';
import 'package:studentlounge_mobile/screens/session_screen.dart';

class App extends StatefulWidget {
  final String apiUrl;

  const App({super.key, required this.apiUrl});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
        child: MaterialApp(
            theme: ThemeData(fontFamily: "Exo2"),
            home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
              if (state.isLoggedIn) {
                return Provider<AppStudentServices>(
                    create: (_) => AppStudentServices(
                        apiUrl: widget.apiUrl, user: state.user),
                    child: const SessionPage());
              } else {
                return Provider<AppAnonymServices>(
                    create: (_) => AppAnonymServices(apiUrl: widget.apiUrl),
                    child: LoginPage());
              }
            })));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
