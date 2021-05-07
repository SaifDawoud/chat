import '../screens/individual_page.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;

  const CustomCard({Key key, this.chatModel,this.sourceChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IndividualPage(chatModel: chatModel,sourceChat:sourceChat ,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              /*child: SvgPicture.asset(
                "assets/icons/${chatModel.icon}",
                color: Colors.white,
                height: 37,
                width: 37,
              ),*/
              radius: 25,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 20),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
