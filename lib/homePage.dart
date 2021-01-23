import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:vaccinemgmt/chat_screen.dart';
import 'package:vaccinemgmt/feed_screen.dart';
import 'package:vaccinemgmt/leaderboard.dart';
import 'package:vaccinemgmt/Qrpage.dart';

import 'package:vaccinemgmt/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  List<Widget> _children = [
    QrPage(),
    Leaderboard(),
    FeedScreen(),
    ChatScreen(),
    User(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal[200],
          unselectedItemColor: Colors.white,
          elevation: 0,
          iconSize: 28,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.qrcode),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.signal),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.user),
              label: "Profile",
            ),
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
