import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/constt.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vaccinemgmt/MyPage.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        margin: EdgeInsets.all(42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi Janhavi',
                  style: ktext,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyPage();
                      }));
                    },
                    child: Icon(
                      Icons.category,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 18, top: 8, bottom: 8),
                      child: Text(
                        'Games',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 18, top: 8, bottom: 8),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Text(
                'Continue Playing',
                style: ktext,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Transform(
                    transform: Matrix4.skewY(-0.05),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // colors: [Color(0x000000), Color(0xBB923CB5)],
                          colors: [
                            Color.fromRGBO(209, 4, 43, 1),
                            Color.fromRGBO(214, 61, 99, 1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Angry Birds 2',
                          style: ktext,
                        ),
                        Text(
                          'LEVEL 20',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 6.0,
                                animation: true,
                                percent: 0.2,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.black87,
                              ),
                              Transform(
                                transform: Matrix4.skewX(-0.05),
                                origin: Offset(50.0, 50.0),
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                      'PLAY',
                                      style: TextStyle(
                                          color: Colors.red.shade600,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 190,
                    child: Image(
                      image: AssetImage('assets/images/angryBird.png'),
                      height: 140,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Discover Games',
                style: ktext,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Transform(
                        transform: Matrix4.skewY(-0.2),
                        origin: Offset(50.0, 50.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: 270,
                          width: 170,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(234, 70, 61, 1),
                                Color.fromRGBO(238, 109, 43, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Super\nMario Run',
                              style: ktext,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 196, 148, 1)
                                    .withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '3.5',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              '100M+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 170,
                        left: 20,
                        child: Image(
                          image: AssetImage('assets/images/mario.png'),
                          height: 160,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Transform(
                        transform: Matrix4.skewY(-0.2),
                        origin: Offset(50.0, 50.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: 270,
                          width: 170,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(209, 145, 44, 1),
                                Color.fromRGBO(212, 155, 101, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clash of\nClans',
                              style: ktext,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '4.6',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              '500M+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 170,
                        left: 20,
                        child: Image(
                          image: AssetImage('assets/images/clashofclans.png'),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
