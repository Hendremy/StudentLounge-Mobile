import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/models/chat_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ChatButton extends StatelessWidget {
  final Chat chat;
  final Function(Chat chat) onPressed;

  const ChatButton({super.key, required this.chat, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: theme.secondary,
        child: ListTile(
            onTap: () => onPressed(chat),
            trailing: const Icon(
              Icons.chevron_right,
              size: 40,
              color: theme.white,
            ),
            title: Text("${chat.name}",
                style: const TextStyle(color: theme.white, fontSize: 30))));
  }
}
