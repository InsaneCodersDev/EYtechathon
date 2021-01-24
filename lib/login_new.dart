import 'package:vaccinemgmt/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:vaccinemgmt/homePage.dart';
import 'package:vaccinemgmt/screens/Signup/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

String loginurl = global.tunneldomain + "/database/login";
TextEditingController aadhaarController = new TextEditingController();
TextEditingController pwdController = new TextEditingController();

SharedPreferences localStorage;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}

TextEditingController emailController = new TextEditingController();

class _LoginState extends State<Login> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // String email, password;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            body: Builder(
              builder: (ctx) => SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.lightGreen[400], BlendMode.modulate),
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
                                      image: AssetImage(
                                          'assets/images/light-1.png'),
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
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
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
                                          controller: aadhaarController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Aadhaar number",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                          onChanged: (text) {
                                            localStorage.setString(
                                                'email', text);
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: pwdController,
                                          obscureText: true,
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
                              MaterialButton(
                                onPressed: () async {
                                  await Login.init();

                                  var data = {
                                    "aadhar": aadhaarController.text.toString(),
                                    "password": pwdController.text.toString()
                                  };
                                  http
                                      .post(loginurl, body: data)
                                      .then((value) => {
                                            print(value.body),
                                            if (value.body == "True")
                                              {
                                                localStorage.setString(
                                                    'authenticated', "true"),
                                                print(localStorage.getString(
                                                    'authenticated')),
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            new HomePage()))
                                              }
                                            else
                                              {
                                                print("flase"),
                                                Scaffold.of(ctx).showSnackBar(
                                                    SnackBar(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content:
                                                            Text(value.body),
                                                        backgroundColor:
                                                            Colors.red))
                                              }
                                          });
                                },
                                child: Container(
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
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FadeAnimation(
                              2,
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              new SignUpScreen()));
                                },
                                child: Text(
                                  "Don't have an account ? Signup",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Varela",
                                      color: Colors.teal[200]),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            FadeAnimation(
                              1.5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  // Icon(FontAwesomeIcons.facebookSquare,
                                  //     size: 25, color: Colors.teal[200]),
                                  MaterialButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });

                                      print("The Loading Status is: " +
                                          loading.toString());
                                      // global.userinst.update({
                                      //   'authid': FieldValue.arrayUnion([global.authid])
                                      // });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.googlePlusSquare,
                                      size: 28,
                                      color: Colors.teal[200],
                                    ),
                                  ),
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
            ),
          );
  }
}
