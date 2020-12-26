import 'package:vaccinemgmt/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:vaccinemgmt/services/auth.dart';
import 'package:vaccinemgmt/homePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // String email, password;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.green[400], BlendMode.modulate),
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/light-1.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: FadeAnimation(
                                1.3,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-2.png'))),
                                )),
                          ),
                          // Positioned(
                          //   right: 40,
                          //   top: 40,
                          //   width: 80,
                          //   height: 150,
                          //   child: FadeAnimation(
                          //       1.5,
                          //       Container(
                          //         decoration: BoxDecoration(
                          //             image: DecorationImage(
                          //                 image: AssetImage(
                          //                     'assets/images/clock.png'))),
                          //       )),
                          // ),
                          Positioned(
                            child: FadeAnimation(
                                1.6,
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: "Varela",
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.8,
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email or Phone number",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                            2,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    // Color.fromRGBO(143, 148, 251, 1),
                                    // Color.fromRGBO(143, 148, 251, .6),
                                    Colors.teal[200],
                                    Colors.grey[700]
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Varela",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                            2,
                            Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Varela",
                                  color: Colors.teal[200]),
                            ),
                          ),
                          SizedBox(height: 50),
                          FadeAnimation(
                            1.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.facebookSquare,
                                    size: 25, color: Colors.teal[200]),
                                MaterialButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    print(global.authid);
                                    print("The Loading Status is: " +
                                        loading.toString());
                                    // global.userinst.update({
                                    //   'authid': FieldValue.arrayUnion([global.authid])
                                    // });
                                    dynamic result =
                                        await _auth.googleSignIn(null);
                                    if (result != null) {
                                      print("User is " + result.uid);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    } else {
                                      print("Problem in signing in");
                                      setState(() {
                                        loading = true;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    size: 25,
                                    color: Colors.teal[200],
                                  ),
                                ),
                                Icon(FontAwesomeIcons.twitter,
                                    size: 25, color: Colors.teal[200]),
                                Icon(FontAwesomeIcons.instagram,
                                    size: 25, color: Colors.teal[200]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}