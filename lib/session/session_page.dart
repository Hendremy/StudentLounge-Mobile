import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:studentlounge_mobile/session/lessons/lessons_repository.dart';
import 'chat/chat_page.dart';
import 'lessons/lessons_page.dart';
import 'schedule/schedule_page.dart';

import '../theme.dart' as theme;

class Session extends StatefulWidget {
  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  var repo = LessonsRepository();
  int currentTab = 0;
  //final List<Widget> pges = [ChatPage(), LessonsPage(repo), SchedulePage()];

  changeTab(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}
