// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vaccinemgmt/models/user.dart';
import 'package:vaccinemgmt/login_new.dart';
// import 'package:vaccinemgmt/globals.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccinemgmt/shared/loading.dart';

SharedPreferences localStorage;
bool loading = true;

class Authenticate extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}

class _LoginState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    dataget();
    return Container(
        padding: EdgeInsets.all(0),
        child: loading
            ? Loading()
            : localStorage == null
                ? Login()
                : HomePage());
  }

  dataget() async {
    await Authenticate.init();
    localStorage.getString('aadhaar');
    localStorage.getString('password');
    loading = false;
    setState(() {});
  }
}
