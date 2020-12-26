import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:mydonationapp/screens/Login/login_screen.dart';
import 'package:mydonationapp/screens/Signup/components/background.dart';
import 'package:mydonationapp/screens/Signup/components/or_divider.dart';
// import 'package:mydonationapp/screens/Signup/components/social_icon.dart';
// import 'package:mydonationapp/components/already_have_an_account_acheck.dart';
import 'package:mydonationapp/components/rounded_button.dart';
import 'package:mydonationapp/components/rounded_input_field.dart';
import 'package:mydonationapp/components/rounded_password_field.dart';
import 'package:mydonationapp/homePage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mydonationapp/services/auth.dart';
import 'package:mydonationapp/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mydonationapp/globals.dart' as global;

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
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "YellowTail",
                        fontSize: 50),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LiteRollingSwitch(
                        //initial value
                        value: true,
                        textOn: '  Donor ',
                        textOff: 'NGO   ',
                        colorOn: Colors.deepPurple[400],
                        colorOff: Colors.deepPurple,
                        iconOn: FontAwesomeIcons.gift,
                        iconOff: FontAwesomeIcons.signLanguage,
                        textSize: 18.0,
                        onChanged: (bool state) {
                          //Use it to manage the different states
                          currentstate = state;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RoundedButton(
                          width: MediaQuery.of(context).size.width * 0.45,
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
                  OrDivider(),
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

                          dynamic result =
                              await _auth.googleSignIn(currentstate);
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
                  )
                ],
              ),
            ),
          );
  }
}
