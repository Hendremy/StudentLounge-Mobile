import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Messagerie',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: Center(child: Text('Messagerie')));
  }
}
