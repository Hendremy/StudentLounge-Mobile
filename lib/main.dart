import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/Lesson/lesson_repository.dart';
import 'Authentication/authentication_bloc.dart';
import 'Authentication/authentication_events.dart';
import 'Authentication/authentication_state.dart';
import 'Lesson/lesson_page.dart';
import 'Login/login_page.dart';
import 'lounge/lounge.dart';
import 'Page/loading_indicator.dart';
import 'Page/splash_page.dart';
import 'Authentication/user_repository.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}

void main() async {
  //BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository(), lessonRepository: LessonRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  final LessonRepository lessonRepository;

  App({Key? key, required this.userRepository, required this.lessonRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;
  LessonRepository get lessonRepository => widget.lessonRepository;

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
      create: (BuildContext context) => AuthenticationBloc(userRepository: userRepository),
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            return Lounge();
          },
        ),
      ),
    );
  }
}