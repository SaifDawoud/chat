import 'package:flutter/material.dart';
import '../custom_ui/custom_card.dart';
import '../models/chat_model.dart';
import '../screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  ChatPage({this.chatModels, this.sourceChat});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.chatModels.length,
          itemBuilder: (BuildContext context, index) {
            return CustomCard(
              chatModel: widget.chatModels[index],
              sourceChat: widget.sourceChat,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (contxt) => SelectContact()));
        },
      ),
    );
  }
}
