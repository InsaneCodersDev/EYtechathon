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
    final user = Provider.of<User>(context);
    if (user == null) {
      print("user null");
      return Login();
    } else {
      // print(user);
      print("Hello");
      DocumentReference userinst =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      global.userinst = userinst;
      global.userinst.update({
        'authid': FieldValue.arrayUnion([global.authid])
      });
      CollectionReference ngoinst =
          FirebaseFirestore.instance.collection('users');
      global.requestinst = FirebaseFirestore.instance.collection('donors');
      global.ngoinst = ngoinst;
      global.uid = user.uid;
      global.getdata();
      global.getrequests('ngouid');
      global.getrequests('uid');
      // global.getngodata();
      return HomePage();
    }
  }
}
