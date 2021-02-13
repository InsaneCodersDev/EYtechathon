import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vaccinemgmt/quiz.dart';

class QuizHeader extends StatelessWidget {
  final String quizHeader;
  final String imgurl;
  QuizHeader(this.quizHeader, this.imgurl);
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.952,
          height: 170,
          // width: double.infinity,
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
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quizHeader,
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
                padding: const EdgeInsets.only(top: 20, right: 15, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => QuizWiz()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 220,
          child: Image.network(
            imgurl,
            height: 155,
          ),
        ),
      ],
    );
  }
}
