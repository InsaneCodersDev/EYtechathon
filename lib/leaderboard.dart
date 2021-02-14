import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/MyPage.dart';
import 'package:vaccinemgmt/QuizHeader.dart';
import 'package:vaccinemgmt/covidhero.dart';
import 'package:vaccinemgmt/immunostories.dart';
import 'dart:io';
import 'globals.dart' as global;
import 'dart:convert';

var quizes = [];

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  bool loaded = false;

  Future _getQuizes() async {
    quizes = [];
    loaded = true;
    var httpClient = new HttpClient();
    print(global.tunneldomain.substring(7));
    var uri =
        new Uri.http(global.tunneldomain.substring(7), '/database/getQuiz');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);

    for (var quiz in jsonDecode(responseBody)) {
      quizes.add(QuizHeader(quiz['quiz_name'], quiz['quiz_url']));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getQuizes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.fromLTRB(28, 28, 28, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi! Janhavi',
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
              ],
            ),
          ),
          Container(
              height: 190,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  children: [for (var quiz in quizes) quiz])),

          Padding(
            padding: EdgeInsets.only(top: 15, right: 280, left: 10),
            child: Text(
              'Explore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
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
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => new StoryPage()));
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
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
                        bottom: 175,
                        left: 0,
                        child: Image(
                          image: AssetImage('assets/images/his.png'),
                          height: 125,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => new CovidHeroPage()));
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
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
                        bottom: 100,
                        left: 40,
                        child: Image(
                          image: AssetImage('assets/images/h1.png'),
                          height: 255,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
