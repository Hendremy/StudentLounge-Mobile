import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:studentlounge_mobile/blocs/session/session_bloc.dart';
import 'package:studentlounge_mobile/blocs/session/session_state.dart';
import 'package:studentlounge_mobile/models/app_user.dart';
import 'package:studentlounge_mobile/tabs/chat_tab.dart';
import 'package:studentlounge_mobile/tabs/lessons_tab.dart';
import 'package:studentlounge_mobile/tabs/profile_tab.dart';
import 'package:studentlounge_mobile/tabs/schedule_tab.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final List<Widget> _pages = [
    ChatTab(),
    LessonsTab(),
    ScheduleTab(),
    ProfileTab()
  ];
  int _currentTab = 0;

  changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  //TODO: Utiliser PageView pour naviguer entre les pages pour garder leur état

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
                  GButton(icon: Icons.messenger_outline, text: "Chat"),
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
