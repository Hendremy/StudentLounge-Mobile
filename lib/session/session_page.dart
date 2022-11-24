import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:studentlounge_mobile/services/api_service.dart';
import 'package:studentlounge_mobile/session/lessons/lessons_bloc.dart';
import 'package:studentlounge_mobile/session/profile/profile_page.dart';

import '../theme.dart' as theme;
import 'chat/chat_page.dart';
import 'lessons/lessons_page.dart';
import 'schedule/schedule_page.dart';
import 'session_bloc.dart';
import 'session_state.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final List<Widget> _pages = [
    ChatPage(),
    LessonsPage(lessonsBloc: BlocProvider.of<LessonsBloc>(context)),
    SchedulePage(),
    ProfilePage()
  ];
  int _currentTab = 0;

  changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  //widget.appBloc pour accéder au token de l'user

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>(
      create: (BuildContext context) => SessionBloc(),
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          return Scaffold(
            body: _pages[_currentTab],
            bottomNavigationBar: GNav(
                backgroundColor: theme.primaryDark,
                color: Colors.white,
                activeColor: theme.activeIcon,
                gap: 8,
                onTabChange: changeTab,
                tabs: const [
                  GButton(icon: Icons.messenger_outline, text: "Messagerie"),
                  GButton(icon: Icons.import_contacts_outlined, text: "Cours"),
                  GButton(icon: Icons.calendar_month_outlined, text: "Horaire"),
                  GButton(icon: Icons.person_outline, text: 'Profil')
                ]),
          );
        },
      ),
    );
  }
}
