import 'package:flutter/material.dart';
import 'package:vaccinemgmt/quizModel.dart';

void main() => runApp(QuizWiz());

class QuizWiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz app',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var counter = 0;

  List qList = [
    Questions("1. Which of the following is not a Covid Vaccine ", 4, "Pfizer",
        "Covishield", "Covaxin", "Covidio"),
    Questions("2.Kelvin is a measure of temperature.", 2, "Option A",
        "Option B", "Option C", "Option D"),
    Questions("3.The Atlantic Ocean is the biggest ocean on Earth.", 1,
        "Option A", "Option B", "Option C", "Option D"),
    Questions("4.Sharks are mammals.", 4, "Option A", "Option B", "Option C",
        "Option D"),
    Questions("5.The human skeleton is made up of less than 100 bones.", 1,
        "Option A", "Option B", "Option C", "Option D"),
    Questions("6.Atomic bombs work by atomic fission.", 1, "Option A",
        "Option B", "Option C", "Option D"),
    Questions("7.Molecules are chemically bonded.", 1, "Option A", "Option B",
        "Option C", "Option D"),
    Questions("8.Spiders have six legs.", 1, "Option A", "Option B", "Option C",
        "Option D"),
    Questions("9.Mount Kilimanjaro is the tallest mountain in the world.", 1,
        "Option A", "Option B", "Option C", "Option D"),
    Questions("10.The study of plants is known as botany.", 1, "Option A",
        "Option B", "Option C", "Option D"),
  ];

  var score = 0;

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
      if (counter < 9) {
        counter = counter + 1;
      }
    });
  }

  reset() {
    setState(() {
      counter = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.teal[600],
      //   title: Text(
      //     'QUIZ',
      //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
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
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 50.0, 10.0),
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
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 10.0),
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
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 10.0),
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
