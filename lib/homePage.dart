import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mydonationapp/addnew.dart';
import 'package:mydonationapp/newRequests.dart';
// import 'package:mydonationapp/screens/profile.dart';
import 'package:mydonationapp/transactions.dart';
import 'package:mydonationapp/donationsListings.dart';
import 'package:mydonationapp/newRequests.dart';

import 'package:mydonationapp/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  List<Widget> _children = [
    Addnew(),
    NewRequests(),
    Donations(),
    Transactions(),
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
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.white,
          elevation: 0,
          iconSize: 32,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.plus_square),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.bell_o),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.history),
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
