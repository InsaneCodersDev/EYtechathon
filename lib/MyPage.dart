import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/constt.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        floatingActionButton: FabCircularMenu(
            fabMargin: EdgeInsets.fromLTRB(0, 40, 25, 0),
            alignment: Alignment.topRight,
            ringDiameter: 450.0,
            ringWidth: 120.0,
            fabElevation: 5,
            animationCurve: Curves.easeIn,
            ringColor: Colors.teal[400],
            fabColor: Colors.teal[400],
            fabCloseIcon: Icon(
              FontAwesomeIcons.trophy,
              color: Colors.yellow[800],
              size: 30,
            ),
            fabOpenIcon: Icon(
              FontAwesomeIcons.trophy,
              color: Colors.white,
              size: 30,
            ),
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/face1.png'),
                height: 60,
              ),
              Image(
                image: AssetImage('assets/images/face2.png'),
                height: 50,
              ),
              Image(
                image: AssetImage('assets/images/face3.png'),
                height: 50,
              ),
              Image(
                image: AssetImage('assets/images/face4.png'),
                height: 60,
              ),
              Image(
                image: AssetImage('assets/images/face5.png'),
                height: 50,
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
                        'Janhavi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      ),
                      Text(
                        'COVID Soldier',
                        style: TextStyle(
                          color: Colors.teal[200],
                          fontSize: 15,
                        ),
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
                style: TextStyle(
                  color: Colors.teal[200],
                  fontSize: 32,
                ),
              ),
              Text(
                'Reviews',
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
                style: TextStyle(
                  color: Colors.teal[200],
                  fontSize: 35,
                ),
              ),
              Text(
                'Stars',
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
                '280',
                style: TextStyle(
                  color: Colors.teal[200],
                  fontSize: 44,
                ),
              ),
              Text(
                'Points',
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
                  color: Colors.teal[200],
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
                          color: Colors.teal,
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
                        image: AssetImage('assets/images/face10.png'),
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
                          color: Colors.teal[400],
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
                        image: AssetImage('assets/images/face11.png'),
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
                          color: Colors.teal[300],
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
                        image: AssetImage('assets/images/face12.png'),
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
                          color: Colors.teal[200],
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
                        image: AssetImage('assets/images/face13.png'),
                        height: 38,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
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
                        image: AssetImage('assets/images/face55.png'),
                        height: 39,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
