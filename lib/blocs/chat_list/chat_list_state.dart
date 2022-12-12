import 'package:studentlounge_mobile/models/chat_model.dart';

abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoadingFailed extends ChatListState {
  final String error;

  ChatListLoadingFailed({required this.error});
}

class ChatListLoaded extends ChatListState {
  final List<Chat> chatList;

  ChatListLoaded({required this.chatList});
}
