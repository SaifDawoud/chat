import 'package:chat_sojsmon/custom_ui/avatar_card.dart';
import 'package:chat_sojsmon/custom_ui/contact_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/chat_model.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "ahmed", status: " web developer "),
    ChatModel(name: "bolbol", status: " flutter developer "),
    ChatModel(name: "aya", status: " web developer "),
  ];
  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "add participants",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (contacts[index].isSelected == false) {
                        setState(() {
                          contacts[index].isSelected = true;
                          groups.add(contacts[index]);
                        });
                      } else {
                        setState(() {
                          contacts[index].isSelected = false;
                          groups.remove(contacts[index]);
                        });
                      }
                    },
                    child: ContactCard(contacts[index]));
              }),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].isSelected == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      contacts[index].isSelected = true;
                                      groups.add(contacts[index]);
                                    });
                                  },
                                  child: AvatarCard(contacts[index]));
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
