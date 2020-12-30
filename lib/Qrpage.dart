import 'package:flutter/material.dart';
import 'package:vaccinemgmt/generate.dart';
import 'package:vaccinemgmt/scan.dart';

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "QR Scanner",
              style: TextStyle(
                color: Colors.teal[200],
                fontSize: 45,
                fontFamily: "yellowTail",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image(
                image: NetworkImage(
                    "https://image.freepik.com/free-vector/qr-code-scanning-with-characters_23-2148635444.jpg")),
            SizedBox(
              height: 50.0,
            ),
            flatButton("Scan QR CODE", ScanPage()),
            SizedBox(
              height: 15.0,
            ),
            flatButton("Generate QR CODE", GeneratePage()),
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(
            color: Colors.teal[200],
            fontFamily: "Varela",
            fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.teal[200], width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
