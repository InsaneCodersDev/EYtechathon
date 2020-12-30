import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/constt.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 30, 83, 1),
      floatingActionButton: FabCircularMenu(
          alignment: Alignment.topRight,
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabElevation: 5,
//          animationCurve: Curves.easeInOutQuad,
          ringColor: Color.fromRGBO(209, 164, 231, 1),
          fabColor: Colors.white,
          fabCloseIcon: Icon(
            Icons.supervised_user_circle,
            color: Colors.black,
            size: 60,
          ),
          fabOpenIcon: Icon(
            Icons.supervised_user_circle,
            color: Colors.black,
            size: 60,
          ),
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/face1.png'),
              height: 60,
            ),
            Image(
              image: AssetImage('assets/images/face2.png'),
              height: 60,
            ),
            Image(
              image: AssetImage('assets/images/face3.png'),
              height: 60,
            ),
            Image(
              image: AssetImage('assets/images/face4.png'),
              height: 60,
            ),
            Image(
              image: AssetImage('assets/images/face5.png'),
              height: 60,
            ),
          ]),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Christina',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                      ),
                    ),
                    Text(
                      '@ch_jones',
                      style: ksmalltext,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '32',
              style: klarge,
            ),
            Text(
              'Followers',
              style: ksmalltext,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white.withOpacity(0.7),
              endIndent: 280,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '19',
              style: klarge,
            ),
            Text(
              'Following',
              style: ksmalltext,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white.withOpacity(0.7),
              endIndent: 280,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'LEVEL 12',
              style: klarge,
            ),
            Text(
              'Since 5 days',
              style: ksmalltext,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white.withOpacity(0.7),
              endIndent: 280,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Leaderboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/face1.png'),
                      height: 40,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/face2.png'),
                      height: 40,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/face3.png'),
                      height: 40,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/face4.png'),
                      height: 40,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/face5.png'),
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
