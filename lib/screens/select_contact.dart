import 'package:chat_sojsmon/custom_ui/contact_card.dart';
import 'package:chat_sojsmon/screens/create_group.dart';

import '../custom_ui/button_card.dart';
import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class SelectContact extends StatefulWidget {
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "ahmed", status: " web developer "),
      ChatModel(name: "bolbol", status: " flutter developer "),
      ChatModel(name: "aya", status: " web developer "),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "256 Contacts",
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
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Invite a Friend"),
                  value: "Invite a Friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
            onSelected: (selectedVal) {
              print(selectedVal);
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => CreateGroup()));
                },
                child: ButtonCard(
                  name: "New group",
                  icon: Icons.group,
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                name: "new contact",
                icon: Icons.person_add,
              );
            }
            return ContactCard(contacts[index - 2]);
          }),
    );
  }
}
