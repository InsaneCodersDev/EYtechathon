import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccinemgmt/models/user.dart';
import 'package:vaccinemgmt/login_new.dart';
import 'package:vaccinemgmt/globals.dart' as global;

class Authenticate extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
