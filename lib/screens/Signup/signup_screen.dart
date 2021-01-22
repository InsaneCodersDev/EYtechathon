import 'package:flutter/material.dart';
import 'package:vaccinemgmt/screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              // colors: [Color(0x000000), Color(0xBB923CB5)],
              colors: [
                Colors.teal[200],
                Colors.black,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Body(),
      ),
    );
  }
}
