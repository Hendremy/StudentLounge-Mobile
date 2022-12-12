import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

import '../widgets/messages.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final int chatId;
  const ChatPage({super.key, required this.email, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.primary,
          title: Center(
              child: Text(widget.email,
                  style: const TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Messages(
                chatId: widget.chatId,
                name: widget.email,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.lightgrey,
                          hintText: 'message',
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: theme.activeIcon),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {},
                        onSaved: (value) {
                          message.text = value!;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (message.text.isNotEmpty) {
                          fb.collection('messages${widget.chatId}').doc().set({
                            'message': message.text.trim(),
                            'time': DateTime.now(),
                            'name': widget.email,
                          });

                          message.clear();
                        }
                      },
                      icon: const Icon(Icons.send_sharp),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
