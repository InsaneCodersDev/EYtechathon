import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vaccinemgmt/MyPage.dart';
import 'package:vaccinemgmt/quiz.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            height: 450,
            margin: EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi Janhavi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
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
                          color: Colors.teal[200],
                          size: 30,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal[400],
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8),
                          child: Text(
                            'Quizes',
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
                          color: Color.fromRGBO(81, 73, 112, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8),
                          child: Text(
                            'Activites',
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
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Take A Quiz',
                    style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
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
                                Colors.teal[200],
                                Colors.black54,
                              ],
                              begin: Alignment.topLeft,
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
                              'Immunisation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '10 Questions',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 45.0,
                                    lineWidth: 4.0,
                                    animation: true,
                                    percent: 0.2,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.black87,
                                  ),
                                  Transform(
                                    transform: Matrix4.skewY(-0.05),
                                    // origin: Offset(50.0, 40.0),
                                    child: Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => QuizWiz()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            'Start',
                                            style: TextStyle(
                                                color: Colors.red.shade600,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                        bottom: 90,
                        left: 220,
                        child: Image(
                          image: AssetImage('assets/images/v2.png'),
                          height: 145,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // End OF Container
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 18),
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
                              Colors.teal[400],
                              Colors.black,
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
                            'Immuno\nHistory',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
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
                                    '10',
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
                            'Tomorrow',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 200,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/images/his.png'),
                        height: 144,
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
                              Colors.teal[400],
                              Colors.black,
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
                            'COVID\nHeroes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
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
                                    '10',
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
                            '2 Days',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 140,
                      left: 40,
                      child: Image(
                        image: AssetImage('assets/images/h1.png'),
                        height: 255,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
