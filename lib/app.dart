import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:studentlounge_mobile/blocs/app/app_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_state.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';
import 'package:studentlounge_mobile/screens/login_screen.dart';
import 'package:studentlounge_mobile/screens/session_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class App extends StatefulWidget {
  final String apiUrl;
  final String downloadPath;

  const App({super.key, required this.apiUrl, required this.downloadPath});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            SfGlobalLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en',''),
            Locale('fr','')
          ],
          locale: const Locale('fr',''),
          theme: ThemeData(fontFamily: "Exo2"),
          home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state.isLoggedIn) {
              return Provider<AppStudentServices>(
                  create: (_) => AppStudentServices(
                      apiUrl: widget.apiUrl,
                      user: state.user,
                      downloadPath: widget.downloadPath),
                  child: const SessionScreen());
            } else {
              return Provider<AppAnonymServices>(
                  create: (_) => AppAnonymServices(apiUrl: widget.apiUrl),
                  child: const LoginPage());
            }
          })));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
