import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  final String path;
  CameraViewPage({this.path});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              Icons.crop_rotate,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.title,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 27,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                        maxLines: 6,
                        minLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        decoration: InputDecoration(
                            suffix: CircleAvatar(
                              backgroundColor: Colors.tealAccent[700],
                              radius: 27,
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                            prefix: Icon(Icons.add_photo_alternate,
                                color: Colors.white, size: 27),
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 17),
                            border: InputBorder.none,
                            hintText: "Add Caption...."))))
          ],
        ),
      ),
    );
  }
}
