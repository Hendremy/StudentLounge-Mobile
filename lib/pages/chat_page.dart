import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
