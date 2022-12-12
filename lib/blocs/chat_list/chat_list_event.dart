import 'package:studentlounge_mobile/models/chat_model.dart';

abstract class ChatListEvent {}

class ChatSelected extends ChatListEvent {
  final String chatName;

  ChatSelected(this.chatName);
}

class ChatListLoadRetry extends ChatListEvent {}

class ChatListUpdated extends ChatListEvent {
  final List<Chat> chatList;

  ChatListUpdated({required this.chatList});
}
