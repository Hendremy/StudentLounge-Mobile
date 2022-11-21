import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/session/lessons/lessons_repository.dart';
import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_events.dart';
import 'session/session_router.dart';
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
  final SessionRouter _appRouter = SessionRouter();
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Lounge',
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
