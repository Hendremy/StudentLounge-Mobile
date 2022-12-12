import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/models/chat_model.dart';
import 'package:studentlounge_mobile/repositories/chats_repository.dart';

import 'chat_list_event.dart';
import 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  List<Chat> chatList = [];

  ChatListBloc({
    required this.chatRepository,
  }) : super(ChatListInitial()) {
    on<ChatSelected>((event, emit) async {
      emit(ChatListLoading());
      try {
        await _getChats(event, emit);
      } catch (error) {
        emit(ChatListLoadingFailed(error: error.toString()));
      }
    });

    on<ChatListUpdated>(
        (event, emit) => emit(ChatListLoaded(chatList: event.chatList)));

    on<ChatListLoadRetry>((event, emit) => _getUserChats());

    _getUserChats();
  }

  Future<void> _getChats(
      ChatListEvent event, Emitter<ChatListState> emit) async {}

  Future<void> _getUserChats() async {
    emit(ChatListLoading());
    List<Chat>? loadedChats = await chatRepository.getUserChats();
    if (loadedChats != null) {
      chatList = List.from(loadedChats);
      emit(ChatListLoaded(chatList: chatList));
    } else {
      emit(ChatListLoadingFailed(error: "Erreur lors du chargement des cours"));
    }
  }
}
