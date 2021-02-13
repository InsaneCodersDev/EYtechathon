import 'package:flutter/material.dart';
import 'package:share/share.dart';

class InviteFriend extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Share Intent"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Example on Share Plugin Flutter",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: MaterialButton(
              elevation: 5.0,
              height: 50.0,
              minWidth: 150,
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    'You can now download IMMUNOCHAIN App from here : https://drive.google.com/drive/u/2/folders/1nOWALjUvGpC_ozKkm4Z4h9cdK4QF6i8Z');
              },
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Text(
              "Share with Subject  works only while sharing on email",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
            ),
          ),
          Center(
            child: MaterialButton(
              elevation: 5.0,
              height: 50.0,
              minWidth: 150,
              color: Colors.green,
              textColor: Colors.white,
              child: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    'check out my website https://protocoderspoint.com/',
                    subject: 'Sharing on Email');
              },
            ),
          ),
        ],
      ),
    );
  }
}
