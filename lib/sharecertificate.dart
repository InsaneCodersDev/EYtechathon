import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccinemgmt/share_files_widget.dart';
import 'package:vaccinemgmt/share_text_widget.dart';

class ShareCertificate extends StatelessWidget {
  static final String title = 'YOUR CERTIFICATE';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[900],
        ),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Share text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Share files',
          ),
        ],
        onTap: (int index) => setState(() => this.index = index),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return ShareTextWidget();
      case 1:
        return ShareFilesWidget();
      default:
        return Container();
    }
  }
}
