import 'package:flutter/material.dart';
import '../pages/chat_page.dart';
import '../pages/camera_page.dart';
import "../models/chat_model.dart";

class HomeScreen extends StatefulWidget {
  HomeScreen({this.chatModels, this.sourceChat});
  final ChatModel sourceChat;
  final List<ChatModel> chatModels;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Whatsapp clone'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("New Group"),
                    value: "New Group",
                  ),
                  PopupMenuItem(
                    child: Text("New broadcast"),
                    value: "New broadcast",
                  ),
                  PopupMenuItem(
                    child: Text("whatsapp web"),
                    value: "whatsapp web",
                  ),
                  PopupMenuItem(
                    child: Text("stared messages"),
                    value: "stared messages",
                  ),
                  PopupMenuItem(
                    child: Text("settings"),
                    value: "settings",
                  ),
                ];
              },
              onSelected: (selectedVal) {
                print(selectedVal);
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: "Chats",
              ),
              Tab(text: "Status"),
              Tab(text: "Calls"),
            ],
          )),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
              chatModels: widget.chatModels, sourceChat: widget.sourceChat),
          Text("Status"),
          Text("Calls"),
        ],
      ),
    );
  }
}
