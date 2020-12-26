import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydonationapp/screens/Login/components/background.dart';
import 'package:mydonationapp/screens/Signup/signup_screen.dart';
import 'package:mydonationapp/components/already_have_an_account_acheck.dart';
import 'package:mydonationapp/components/rounded_button.dart';
import 'package:mydonationapp/components/rounded_input_field.dart';
import 'package:mydonationapp/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mydonationapp/services/auth.dart';
import 'package:mydonationapp/homePage.dart';
import 'package:mydonationapp/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mydonationapp/globals.dart' as global;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  String email, password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "YellowTail",
                        fontSize: 50),
                  ),
                  // SizedBox(height: size.height * 0.01),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signinWithEmailAndPassword(
                          email, password);
                      if (result != null) {
                        print(result);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        print("Problem in signing in");
                        loading = false;
                      }
                    },
                  ),
                  // SizedBox(height: size.height * 0.03),
                  // AlreadyHaveAnAccountCheck(
                  //   press: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return SignUpScreen();
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.facebookSquare,
                        size: 32,
                        color: Colors.purple[100],
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          print(global.authid);
                          // global.userinst.update({
                          //   'authid': FieldValue.arrayUnion([global.authid])
                          // });
                          dynamic result = await _auth.googleSignIn(null);
                          if (result != null) {
                            print(result.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            print("Problem in signing in");
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.google,
                          size: 32,
                          color: Colors.purple[100],
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.twitter,
                        size: 32,
                        color: Colors.purple[100],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
