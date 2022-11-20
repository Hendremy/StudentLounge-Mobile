import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/lessons/lessons_repository.dart';
import '../chat/chat_page.dart';
import '../lessons/lessons_page.dart';
import '../schedule/schedule_page.dart';

import '../theme.dart' as theme;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var repo = LessonsRepository();
  int currentTab = 0;
  final List<Widget> pges = [ChatPage(), LessonsPage(repo), SchedulePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
