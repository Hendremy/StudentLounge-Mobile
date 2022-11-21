import 'package:bloc/bloc.dart';

import 'session_events.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionRunning());
}
