import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:studentlounge_mobile/app/app_state.dart';
import 'package:studentlounge_mobile/services/services_providers.dart';
import '../login/login_page.dart';
import '../session/session_page.dart';
import 'app_bloc.dart';

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
              home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state.isLoggedIn) {
              return Provider(
                create: (_) => AppStudentServices(apiUrl: widget.apiUrl, user: state.user),
                child: const SessionPage()
                );
            } else {
              return Provider(
                create: (_) => AppAnonymServices(apiUrl: widget.apiUrl),
                child: LoginPage()
                );
            }
          })));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
