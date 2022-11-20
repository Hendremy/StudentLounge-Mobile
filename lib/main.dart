import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/lessons/lessons_repository.dart';
import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_events.dart';
import 'authentication/authentication_state.dart';
import 'lessons/lessons_page.dart';
import 'login/login_page.dart';
import 'home/home.dart';
import 'page/loading_indicator.dart';
import 'page/splash_page.dart';
import 'authentication/user_repository.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}

void main() async {
  //BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(
      userRepository: UserRepository(), lessonRepository: LessonsRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  final LessonsRepository lessonRepository;

  App({Key? key, required this.userRepository, required this.lessonRepository})
      : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;
  LessonsRepository get lessonRepository => widget.lessonRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) =>
          AuthenticationBloc(userRepository: userRepository),
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            return Home();
          },
        ),
      ),
    );
  }
}
