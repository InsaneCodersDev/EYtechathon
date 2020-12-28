import 'package:flutter/material.dart';
import 'package:vaccinemgmt/models/message_model.dart';
import 'package:vaccinemgmt/models/user_model.dart';
import "package:flutter_dialogflow/dialogflow_v2.dart";

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void response(query) async {
    AuthGoogle authgoogle =
        await AuthGoogle(fileJson: "assets/immunobot-habo-66a9f49e5bf1.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authgoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    print(aiResponse.getListMessage()[0]["text"]["text"][0]);
    setState(() {
      messages.insert(
        0,
        Message(
          response: true,
          time: '4:30 PM',
          text: aiResponse.getListMessage()[0]["text"]["text"][0],
        ),
      );
    });
  }

  _chatBubble(Message message, bool response) {
    if (!response) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !response
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/thor.png'),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          response
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/ironman.jpeg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.grey[900],
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Colors.teal[200],
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.go,
              controller: fieldText,
              onChanged: (input_text) {
                user_input = input_text;
              },
              style: TextStyle(color: Colors.teal[200]),
              cursorColor: Colors.cyan,
              decoration: InputDecoration.collapsed(
                  hintText: 'Send a message..',
                  hintStyle: TextStyle(color: Colors.white)),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.teal[200],
            onPressed: () {
              setState(() {
                messages.insert(
                  0,
                  Message(
                    response: false,
                    time: '4:30 PM',
                    text: user_input,
                  ),
                );
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 1500),
                );
                fieldText.clear();
              });
              response(user_input);
            },
          ),
        ],
      ),
    );
  }

  ScrollController _scrollController = new ScrollController();
  final fieldText = TextEditingController();
  String user_input = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(Icons.menu),
        toolbarHeight: 60,
        backgroundColor: Colors.teal[400],
        // brightness: Brightness.dark,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/thor.png'),
            ),
            SizedBox(width: 15),
            RichText(
              // textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "ImmunoBot",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Online',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.up,
              color: Colors.teal,
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                padding: EdgeInsets.all(20),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = messages[index];
                  return _chatBubble(message, message.response);
                },
              ),
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
