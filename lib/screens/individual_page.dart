import 'package:chat_sojsmon/models/chat_model.dart';
import 'package:chat_sojsmon/models/message_model.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';
import '../custom_ui/message.dart';
import '../custom_ui/reply_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  IndividualPage({this.chatModel, this.sourceChat});

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  @override
  void initState() {
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
    super.initState();
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source",message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      messages.add(messageModel);
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.11:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) => print("connected"));
    print(socket.connected);
    socket.on("message", (msg) {
      setMessage("destination",msg['message']);
      print(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 70,
        leading: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                  /*child: SvgPicture.asset(
                    "assets/icons/${widget.chatModel.icon}",
                    color: Colors.white,
                    height: 37,
                    width: 37,
                  )*/)
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(widget.chatModel.name,
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.bold)),
                ),
                FittedBox(
                    child: Text("Last Seen today a 12:00",
                        style: TextStyle(fontSize: 13))),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.videocam,
              ),
              onPressed: () {}),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("View content"),
                  value: "View content",
                ),
                PopupMenuItem(
                  child: Text("Media, links, and docs"),
                  value: "Media, links, and docs",
                ),
                PopupMenuItem(
                  child: Text("whatsapp web"),
                  value: "whatsapp web",
                ),
                PopupMenuItem(
                  child: Text("search"),
                  value: "search",
                ),
                PopupMenuItem(
                  child: Text("wallpaper"),
                  value: "wallpaper",
                ),
                PopupMenuItem(
                  child: Text("Mute notification"),
                  value: "wallpaper",
                ),
              ];
            },
            onSelected: (selectedVal) {
              print(selectedVal);
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 140,
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      if (messages[index].type == "source") {
                        return MessageCard(
                          message: messages[index].message,
                        );
                      } else {
                        return ReplyCard(message: messages[index].message);
                      }
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: controller,
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showEmoji = !showEmoji;
                                          });
                                        },
                                        icon:
                                            Icon(Icons.emoji_emotions_outlined),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomSheet());
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.camera_alt),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CameraScreen()));
                                              }),
                                        ],
                                      ),
                                      hintText: "Type a Message",
                                      contentPadding: EdgeInsets.all(5)),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 5, left: 2),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF128C7E),
                            child: IconButton(
                              icon: Icon(
                                sendButton ? Icons.send : Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (sendButton) {
                                  sendMessage(
                                      controller.text,
                                      widget.sourceChat.id,
                                      widget.chatModel.id);
                                  controller.clear();
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    showEmoji ? emojiContainer() : Container()
                  ],
                ),
              ),
            ],
          ),
          onWillPop: () {
            if (showEmoji) {
              setState(() {
                showEmoji = false;
              });
            } else {
              Navigator.of(context).pop();
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
            margin: EdgeInsets.all(18),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    iconCreation(
                        Icons.insert_drive_file, Colors.indigo, "Document"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    iconCreation(Icons.headset, Colors.orange, "Audio"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.location_pin, Colors.pink, "Location"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.person, Colors.blue, "Contact"),
                  ]),
                ],
              ),
            )));
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 28,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget emojiContainer() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            controller.text = controller.text + emoji.emoji;
          });
        });
  }
}
