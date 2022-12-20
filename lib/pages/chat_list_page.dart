import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/chat_list/chat_list_bloc.dart';
import 'package:studentlounge_mobile/blocs/chat_list/chat_list_event.dart';
import 'package:studentlounge_mobile/blocs/chat_list/chat_list_state.dart';
import 'package:studentlounge_mobile/models/chat_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/widgets/center_message.dart';
import 'package:studentlounge_mobile/widgets/chat_button_list.dart';
import 'package:studentlounge_mobile/widgets/loading_indicator.dart';
import 'package:studentlounge_mobile/widgets/retry_message.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late final ChatListBloc chatListBloc;

  @override
  void initState() {
    chatListBloc = BlocProvider.of<ChatListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(builder: (
      BuildContext context,
      ChatListState state,
    ) {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: theme.primary,
              title: const Text('Messages',
                  style: TextStyle(fontSize: 30, fontFamily: 'Gugi'))),
          body: _renderBody(state));
    });
  }

  _renderBody(ChatListState state) {
    if (state is ChatListLoaded) {
      if (state.chatList.isEmpty) {
        return const CenterMessage(text: "Vous n'avez de discussions");
      } else {
        return ChatButtonList(
            chatList: state.chatList, onPressed: _onChatButtonPressed);
      }
    } else if (state is ChatListLoading) {
      return LoadingIndicator();
    } else {
      return RetryMessage(
          text: "Erreur lors du chargement de vos disscussions", retry: _retry);
    }
  }

  _onChatButtonPressed(Chat chat) {
    Navigator.pushNamed(context, 'chat', arguments: chat);
  }

  _retry() {
    chatListBloc.add(ChatListLoadRetry());
  }
}
