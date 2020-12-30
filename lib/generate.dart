import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:vaccinemgmt/globals.dart' as globals;

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  String qrData =
      "Janhavi Zarapkar"; // already generated qr code when the page opens
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Padding(
          padding: EdgeInsets.all(30),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "QR Code",
                style: TextStyle(
                    fontFamily: "yellowTail", fontSize: 55, color: Colors.teal),
              ),
              SizedBox(height: 20),
              QrImage(
                backgroundColor: Colors.black,
                foregroundColor: Colors.teal,

                //plce where the QR Image will be shown
                data: qrData,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "This QR Code will help the Vaccinator instantly verify your identity before Vaccination",
                style: TextStyle(fontSize: 18.0, color: Colors.teal),
              ),
              // TextField(
              //   controller: qrdataFeed,
              //   decoration: InputDecoration(
              //       hintText: "Input your link or data",
              //       hintStyle: TextStyle(color: Colors.teal)),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              //   child: FlatButton(
              //     padding: EdgeInsets.all(15.0),
              //     onPressed: () async {
              //       if (qrdataFeed.text.isEmpty) {
              //         //a little validation for the textfield
              //         setState(() {
              //           qrData = "";
              //         });
              //       } else {
              //         setState(() {
              //           qrData = qrdataFeed.text;
              //         });
              //       }
              //     },
              //     child: Text(
              //       "Generate QR",
              //       style: TextStyle(
              //           color: Colors.blue, fontWeight: FontWeight.bold),
              //     ),
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(color: Colors.blue, width: 3.0),
              //         borderRadius: BorderRadius.circular(20.0)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
