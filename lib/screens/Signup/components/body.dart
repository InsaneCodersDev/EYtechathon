import 'package:flutter/material.dart';
import 'package:vaccinemgmt/components/rounded_button.dart';
import 'package:vaccinemgmt/components/rounded_input_field.dart';
import 'package:vaccinemgmt/components/rounded_password_field.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:vaccinemgmt/shared/loading.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:http/http.dart' as http;

TextEditingController otpController = new TextEditingController();
TextEditingController aadhaarController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
final String otpurl = global.tunneldomain + "/database/generateotp";
final String signupurl = global.tunneldomain + "/database/signup";

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password;
  bool loading = false;

  bool currentstate;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: Builder(
              builder: (ctx) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      // colors: [Color(0x000000), Color(0xBB923CB5)],
                      colors: [
                        Colors.teal[200], //Color(0xBB923CB5)
                        Colors.black87,
                      ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                ),
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
                        controller: aadhaarController,
                        hintText: "Your Aadhaar Number",
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      RoundedPasswordField(
                        controller: passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      RoundedInputField(
                        controller: otpController,
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
                                var data = {
                                  'aadhar': aadhaarController.text.toString()
                                };
                                print(otpController.text.toString());
                                final response = await http
                                    .post(otpurl, body: data)
                                    .then((value) => {
                                          Scaffold.of(ctx).showSnackBar(
                                              SnackBar(
                                                  duration:
                                                      Duration(seconds: 2),
                                                  content: Text(value.body),
                                                  backgroundColor: Colors.red))
                                        });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RoundedButton(
                              width: MediaQuery.of(context).size.width * 0.4,
                              text: "SIGNUP",
                              press: () async {
                                var data = {
                                  "aadhar": aadhaarController.text.toString(),
                                  "password":
                                      passwordController.text.toString(),
                                  "otp": otpController.text.toString()
                                };
                                http.post(signupurl, body: data).then((value) =>
                                    {
                                      Scaffold.of(ctx).showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(value.body),
                                          backgroundColor: Colors.green)),
                                      if (value.body == "True")
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()))
                                        }
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
