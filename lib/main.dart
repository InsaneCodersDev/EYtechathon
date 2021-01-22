import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccinemgmt/authenticate.dart';
import 'package:vaccinemgmt/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vaccinemgmt/services/database.dart';
import 'package:provider/provider.dart';
import 'package:vaccinemgmt/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:http/http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    global.httpClient = Client();
  }

  @override
  Widget build(BuildContext context) {
    _messaging.getToken().then((token) {
      global.authid = token;
    });
    return MultiProvider(
      providers: [
        StreamProvider<User>(create: (_) => AuthService().user),
        StreamProvider<QuerySnapshot>(create: (_) => DatabaseService().users),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
      ),
    );
  }
}
