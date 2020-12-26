import 'package:flutter/material.dart';
import 'package:mydonationapp/authenticate.dart';
// import 'package:mydonationapp/authenticate.dart';
import 'package:mydonationapp/services/auth.dart';
// import 'package:mydonationapp/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Center(
            heightFactor: 22,
            widthFactor: 10,
            child: MaterialButton(
              height: 70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Color(0xff00b4ff), width: 3)),
              onPressed: () async {
                await _auth.signOut();
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Log Out",
                    style: TextStyle(
                        color: Color(0xff00b4ff),
                        fontFamily: "CentraleSansRegular",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
