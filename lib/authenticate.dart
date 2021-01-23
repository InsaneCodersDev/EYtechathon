import 'package:vaccinemgmt/homePage.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/login_new.dart';
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
    return MaterialApp(
        home: loading
            ? Loading()
            : localStorage.getString('authenticated') == "false"
                ? Login()
                : HomePage());
  }

  dataget() async {
    await Authenticate.init();
    loading = false;
    setState(() {});
  }
}
