import 'dart:convert';
import 'package:studentlounge_mobile/models/chat_model.dart';
import 'package:studentlounge_mobile/repositories/api_service.dart';
import 'package:http/http.dart' as http;

abstract class ChatRepository extends StudentApiService {
  ChatRepository(
      {required super.studentId, required super.token, required super.apiUrl, required super.controller});

  Future<dynamic> getUserChats();
}

class AppChatRepository extends ChatRepository {
  AppChatRepository(
      {required super.studentId, required super.token, required super.apiUrl, required super.controller});

  @override
  Future<dynamic> getUserChats() async {
    return await getChatList("/Chat");
  }

  Future<List<Chat>?> getChatList(String options) async {
    http.Response response = await http.get(Uri.parse('$controllerUrl$options'),
        headers: jsonHeaders);
    if (response.statusCode == 200) {
      return convertJSONChatList(response.body);
    }
    return null;
  }

  List<Chat> convertJSONChatList(String jsonList) {
    List<dynamic> chatMapList = jsonDecode(jsonList);
    List<Chat> chatList = [];
    for (var chatMap in chatMapList) {
      chatList.add(Chat.fromMap(chatMap));
    }
    return chatList;
  }
}
