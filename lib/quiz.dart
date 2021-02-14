// import 'dart:io';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/quizModel.dart';
import "package:http/http.dart" as http;
import 'package:vaccinemgmt/globals.dart' as global;

String url = global.tunneldomain + "/database/getQuestions";
List qList = [];

class QuizWiz extends StatelessWidget {
  final String name;
  QuizWiz(this.name);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz app',
      debugShowCheckedModeBanner: false,
      home: StartPage(name),
    );
  }
}

class StartPage extends StatefulWidget {
  final String name;
  StartPage(this.name);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var counter = 0;
  var score = 0;
  bool loading = true;

  checkWin(int userChoice, BuildContext context) {
    if (userChoice == qList[counter].answer) {
      print("correct");

      score = score + 5;
      final snackbar = SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.green,
        content: Text("Correct!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      print("false");
      score = score + 0;
      final snackbar = SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.red,
        content: Text("Incorrect!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
    setState(() {
      if (counter < qList.length - 1) {
        counter = counter + 1;
      } else {
        reset();
      }
    });
  }

  reset() {
    setState(() {
      counter = 0;
      score = 0;
    });
  }

  void _getQuestions() async {
    qList.clear();
    loading = false;
    var data = {
      "name": widget.name,
    };
    await http.post(url, body: data).then((value) => {
          print(jsonDecode(value.body)[0]["quiz_questions"].length),
          for (var question in jsonDecode(value.body)[0]["quiz_questions"])
            {
              print("Adding" + qList.length.toString()),
              qList.insert(
                  0,
                  Questions(
                      question["question"],
                      int.parse(question["answer"]),
                      question["option1"],
                      question["option2"],
                      question["option3"],
                      question["option4"])),
              print(question["url"]),
              print("qLIST: " + qList.toString()),
              print("Adding" + qList.length.toString()),
            }
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loading ? _getQuestions() : null;
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            body: Builder(
              builder: (BuildContext context) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'ImmunoQuiz',
                        style: TextStyle(
                          color: Colors.teal[200],
                          fontFamily: 'Satisfy',
                          fontSize: 45.0,
                          inherit: false,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/png.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Score : $score /50",
                            style: TextStyle(
                                color: Colors.teal[200],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            child: Text(
                              "Reset Game",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: reset,
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.teal[200])),
                      height: 90.0,
                      // width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            child: Text(qList[counter].qText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.teal[200])),
                          child: RaisedButton(
                            onPressed: () => checkWin(1, context),
                            padding: EdgeInsets.fromLTRB(20.0, 00.0, 00.0, 0.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "A. " + qList[counter].OptionA,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.teal[200])),
                          child: RaisedButton(
                            onPressed: () => checkWin(2, context),
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 50.0, 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "B. " + qList[counter].OptionB,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.teal[200])),
                          child: RaisedButton(
                            onPressed: () => checkWin(3, context),
                            padding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "C. " + qList[counter].OptionC,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.teal[200])),
                          child: RaisedButton(
                            onPressed: () => checkWin(4, context),
                            padding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "D. " + qList[counter].OptionD,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
  }
}
