import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/chat_list/chat_list_bloc.dart';
import 'package:studentlounge_mobile/models/chat_model.dart';
import 'package:studentlounge_mobile/pages/chat_list_page.dart';
import 'package:studentlounge_mobile/pages/chat_page.dart';
import 'package:studentlounge_mobile/repositories/services_providers.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  late ChatListBloc chatListBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatListBloc>(create: (context) {
      chatListBloc = ChatListBloc(
          chatRepository: context.read<AppStudentServices>().chatRepo);

      return chatListBloc;
    }, child: Navigator(onGenerateRoute: ((settings) {
      Widget page = const ChatListPage();
      if (settings.name == 'chat') {
        Chat chat = settings.arguments as Chat;
        page = ChatPage(
          email: chat.name,
          chatId: chat.id,
        );
      }
      return MaterialPageRoute(builder: (_) => page);
    })));
  }
}
