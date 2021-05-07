import 'package:chat_sojsmon/models/chat_model.dart';
import 'package:flutter/material.dart';


class ContactCard extends StatelessWidget {
  final ChatModel contact;

  ContactCard(this.contact);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
             /* child: SvgPicture.asset(
                "assets/icons/person.svg",
                color: Colors.white,
                width: 30,
                height: 30,
              ),*/
              backgroundColor: Colors.grey[200],
            ),
            contact.isSelected
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.teal,
                        child:
                            Icon(Icons.check, size: 18, color: Colors.white)),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        contact.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.status,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
