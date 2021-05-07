import 'package:chat_sojsmon/custom_ui/button_card.dart';
import 'package:chat_sojsmon/models/chat_model.dart';
import "package:flutter/material.dart";
import "./home_screen.dart";

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
        name: "saif Dawoud",
        isGroup: false,
        time: "4:00",
        currentMessage: "Hiii",
        icon: "person.svg",
        id: 1),
    ChatModel(
        name: " Dawoud",
        isGroup: false,
        time: "5:00",
        currentMessage: "get back",
        icon: "person.svg",
        id: 2),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chatModels.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    sourceChat = chatModels.removeAt(index);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              chatModels: chatModels,
                              sourceChat: sourceChat,
                            )));
                  },
                  child: ButtonCard(
                    name: chatModels[index].name,
                    icon: Icons.person,
                  ),
                )));
  }
}
