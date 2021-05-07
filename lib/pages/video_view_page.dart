import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPage extends StatefulWidget {
  final String path;
  VideoPreviewPage({this.path});

  @override
  _VideoPreviewPageState createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) => setState(() {}));
  }

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
                child: controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller))
                    : Center(child: CircularProgressIndicator())),
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
                            hintText: "Add Caption....")))),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
