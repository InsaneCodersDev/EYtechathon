import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:vaccinemgmt/screens/Login/login_screen.dart';
import 'package:vaccinemgmt/screens/Signup/components/background.dart';
import 'package:vaccinemgmt/screens/Signup/components/or_divider.dart';
// import 'package:vaccinemgmt/screens/Signup/components/social_icon.dart';
// import 'package:vaccinemgmt/components/already_have_an_account_acheck.dart';
import 'package:vaccinemgmt/components/rounded_button.dart';
import 'package:vaccinemgmt/components/rounded_input_field.dart';
import 'package:vaccinemgmt/components/rounded_password_field.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vaccinemgmt/services/auth.dart';
import 'package:vaccinemgmt/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:vaccinemgmt/globals.dart' as global;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  String email, password;
  bool loading = false;
  List<bool> _selections = [true, false];
  bool currentstate;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "YellowTail",
                        fontSize: 50),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/images/sgnup.png",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    hintText: "Your Aadhaar Number",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "Enter the OTP",
                    icon: Icons.message,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundedButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          text: "GET OTP",
                          press: () async {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, currentstate);
                            if (result != null) {
                              print(result.uid);
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundedButton(
                          width: MediaQuery.of(context).size.width * 0.4,
                          text: "SIGNUP",
                          press: () async {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, currentstate);
                            if (result != null) {
                              print(result.uid);
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
                      ),
                    ],
                  ),
                  // SizedBox(height: size.height * 0.03),
                  // AlreadyHaveAnAccountCheck(
                  //   login: false,
                  //   press: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return LoginScreen();
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          );
  }
}
