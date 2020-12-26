import 'package:flutter/material.dart';
import 'FadeAnimation.dart';
import 'package:flutter/widgets.dart';
import 'package:mydonationapp/services/imagecapture.dart';
import 'package:flutter/cupertino.dart';
import 'package:mydonationapp/globals.dart' as global;
import 'package:awesome_dialog/awesome_dialog.dart';

class Addnew extends StatefulWidget {
  @override
  _AddnewState createState() => _AddnewState();
}

class _AddnewState extends State<Addnew> {
  bool isdonor = global.type == "donor" ? true : false;
  double nos = 1;
  @override
  Widget build(BuildContext context) {
    var x = ["Food", "Clothes", "Toys", "Sanitation", "Electronics", "Other"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xff21254A),
      backgroundColor: Colors.black87,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child: FadeAnimation(
                      1,
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/1.png"),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      isdonor
                          ? Text(
                              "Donate for Good",
                              style: TextStyle(
                                fontSize: 45,
                                fontFamily: "yellowtail",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "Request Donation",
                              style: TextStyle(
                                fontSize: 45,
                                fontFamily: "yellowtail",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    FadeAnimation(
                      1,
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.purple,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Item Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                onChanged: (value) {
                                  global.itemname = value;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.purple,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: global.type == 'donor'
                                        ? "Item details & Pickup"
                                        : "Message to Donors",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) {
                                  global.itempickup = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FadeAnimation(
                      1,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Choose Item Count & Category",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 20,
                        activeColor: Colors.purple,
                        inactiveColor: Colors.deepPurple[300],
                        label: nos.toInt().toString(),
                        value: nos,
                        onChanged: (newnos) {
                          setState(() {
                            nos = newnos;
                          });
                          global.itemcount = nos.toInt().toString();
                        },
                      ),
                    ),
                    FadeAnimation(
                      1,
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        height: 70,
                        child: CupertinoPicker(
                          magnification: 1.3,
                          useMagnifier: true,
                          looping: true,
                          itemExtent: 35,
                          backgroundColor: Colors.grey[900],
                          onSelectedItemChanged: (int l) {
                            global.itemcategory = l;
                          },
                          children: <Widget>[
                            Text(
                              "---- Food ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "---- Clothes ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "---- Toys ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "-- Sanitation --",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "-- Electronics --",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "---- Books ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "-- Medicines --",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "-- Stationery --",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "---- Furniture ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                            Text(
                              "---- Other ----",
                              style: TextStyle(color: Colors.purple[400]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      MaterialButton(
                        onPressed: global.itemname == "" ||
                                global.itempickup == "" ||
                                global.itemcount == 0
                            ? () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  tittle: 'Invalid Entries',
                                  desc:
                                      'Make Sure you Enter both fields correctly & ItemCount is not 0',
                                  btnCancelOnPress: () {},
                                )..show();
                              }
                            : () {
                                global.calledfrom = "addnew";
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageCapture()));
                              },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Add Donation: " + nos.toInt().toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
