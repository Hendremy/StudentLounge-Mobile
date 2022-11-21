import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/session/session_bloc.dart';
import 'package:studentlounge_mobile/session/session_page.dart';

class SessionRouter {
  final SessionBloc _sessionBloc = SessionBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _sessionBloc,
            child: Session(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  void dispose() {
    _sessionBloc.close();
  }
}
