// import 'dart:ffi';
// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaccinemgmt/models/message_model.dart';
import 'package:vaccinemgmt/models/user_model.dart';
import "package:flutter_dialogflow/dialogflow_v2.dart";
import 'package:geolocator/geolocator.dart';
import 'package:linkwell/linkwell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';

SharedPreferences localStorage;

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  bool _uploadenabled = false;

  Future<String> _startUpload(files) async {
    var urls = [];
    await Firebase.initializeApp();
    final FirebaseStorage _storage = FirebaseStorage.instanceFor(
        bucket: 'gs://eytechathon-insanecoders.appspot.com');
    for (var file in files) {
      String fileName = DateTime.now().toString();
      String filePath = 'images/${fileName}';
      await _storage.ref().child(filePath).putFile(File(file.path));
      print(' THis is File name ..........images/${fileName}');
      var ref = await Future.value(_storage.ref().child("images/" + fileName));
      var url = await ref.getDownloadURL();
      print(url);
      urls.add(url);
      messages.insert(
        0,
        Message(
            response: false, time: '4:30 PM', text: url, isImageResponse: true),
      );
    }
    String queryString = "Document: ";
    int i = 0;
    for (var url in urls) {
      String query = queryString + url + " " + i.toString();
      print(query);
      response(query);
      i++;
    }

    /// Unique file name for the file
    // String fileName = DateTime.now().toString();
    // String filePath = 'images/${fileName}';
    // await _storage.ref().child(filePath).putFile(file);
    // print(' THis is File name ..........images/${fileName}');
    // var ref = await Future.value(_storage.ref().child("images/" + fileName));
    // var url = await ref.getDownloadURL();
    // print(url);
    // response("Document:" + url);
    // messages.insert(
    //   0,
    //   Message(
    //       response: false, time: '4:30 PM', text: url, isImageResponse: true),
    // );
    _uploadenabled = false;
    setState(() {});
  }

  void response(query) async {
    AuthGoogle authgoogle =
        await AuthGoogle(fileJson: "assets/immunobot-habo-66a9f49e5bf1.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authgoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);

    if (aiResponse.getListMessage().length > 1) {
      print(aiResponse.getListMessage()[1]["text"]["text"][0]);
      if (aiResponse.getListMessage()[1]["text"]["text"][0] ==
          "Prepare_to_Upload") {
        _uploadenabled = true;
      } else {
        _uploadenabled = false;
      }
    }
    if (aiResponse.getListMessage()[0]["text"]["text"][0] != "") {
      messages.insert(
        0,
        Message(
            response: true,
            time: '4:30 PM',
            text: aiResponse.getListMessage()[0]["text"]["text"][0],
            isImageResponse: false),
      );
      setState(() {});
    }
  }

  void sendData(data) async {
    AuthGoogle authgoogle =
        await AuthGoogle(fileJson: "assets/immunobot-habo-66a9f49e5bf1.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authgoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(data);
  }

  _chatBubble(Message message, bool response, bool isImageResponse) {
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
              child: isImageResponse
                  ?
                  // ? Image.network(
                  //     message.text,
                  //     loadingBuilder: (BuildContext context, Widget child,
                  //         ImageChunkEvent loadingProgress) {
                  //       if (loadingProgress == null) return child;
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     },
                  //   )
                  CachedNetworkImage(
                      imageUrl: message.text,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    )
                  : Text(
                      message.text,
                      style: TextStyle(
                          color: Colors.black87, fontFamily: "Varela"),
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
                        radius: 12,
                        backgroundImage: AssetImage('assets/images/bot.jpg'),
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
              child: isImageResponse
                  ? Image.network(message.text)
                  : LinkWell(
                      message.text,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Varela'),
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
                        radius: 12,
                        backgroundImage: AssetImage('assets/images/bot.jpg'),
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
    print("Problem: " + _uploadenabled.toString());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.grey[900],
      child: Row(
        children: <Widget>[
          IconButton(
            disabledColor: Colors.grey[800],
            icon: Icon(Icons.attach_file_outlined),
            iconSize: 30,
            color: Colors.teal[200],
            onPressed: _uploadenabled
                ? () async {
                    print("Attach");
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowMultiple: true,
                      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
                    );
                    print(result.paths);
                    print(result);
                    // for (var file in result.files) {
                    //   print(file.path);
                    // }
                    // await _startUpload(File(result.files[0].path));
                    await _startUpload(result.files);
                  }
                : null,
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.go,
              controller: fieldText,
              // textInputAction: TextInputAction.send,
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
                      isImageResponse: false),
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

  void getUserLocation() async {
    ChatScreen.init();
    var posn = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastposn = await Geolocator.getLastKnownPosition();
    print(lastposn);
    print(posn.latitude.toString() + "\t" + posn.longitude.toString());
    sendData(posn.latitude.toString() + "\t" + posn.longitude.toString());
    sendData(localStorage.getString('aadhaar'));
  }

  @override
  Widget build(BuildContext context) {
    getUserLocation();
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
              backgroundImage: AssetImage('assets/images/bot.jpg'),
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
                  return _chatBubble(
                      message, message.response, message.isImageResponse);
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
