import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/widgets/chat_button.dart';

import '../models/chat_model.dart';

class ChatButtonList extends StatefulWidget {
  List<Chat> chatList;
  final Function(Chat chat) onPressed;
  ChatButtonList({super.key, required this.chatList, required this.onPressed});

  @override
  State<ChatButtonList> createState() => _ChatButtonListState();
}

class _ChatButtonListState extends State<ChatButtonList> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(8), children: <ChatButton>[
      for (Chat chat in widget.chatList)
        ChatButton(chat: chat, onPressed: widget.onPressed)
    ]);
  }
}
