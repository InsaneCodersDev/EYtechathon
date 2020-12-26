// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mydonationapp/globals.dart' as global;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  String msg = "";
  String rejmsg = "";
  List<Widget> notilist = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    notilist = []; // Never Remive this line
    global.requestlist.forEach((data) async {
      if (data['status'] == 'pending') {
        notilist.add(_pushnotification(
          data['img'],
          data['username'],
          data['itemname'],
          'Qty: ' + data['quantity'].toString(),
          data['phone'],
          data['email'],
          data['reqref'],
        ));
      }
    });
    Future.delayed(Duration(seconds: 1), () async {
      global.getrequests('ngouid');
      setState(() {});
    });

    return Scaffold(
        backgroundColor: Colors.black87,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          // colors: [Color(0x000000), Color(0xBB923CB5)],
                          colors: [
                            Colors.purple[500], //Color(0xBB923CB5)
                            Color(0x21212),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(75.0)),
                      color: Color(0xFFFD7465)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.0, left: 15.0),
                  child: Text(
                    'One for All',
                    style: TextStyle(
                        fontFamily: 'yellowTail',
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 95.0, left: 15.0),
                  child: Text(
                    'New Requests',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height - 370,
                child: ListView(children: notilist)),
            // for (Widget notification in notilist) notification,
            SizedBox(height: 20.0)
          ],
        ));
  }

  _pushnotification(String imgurl, String username, String desc, String price,
      String phone, String emailid, DocumentReference reqref) {
    void makeCall(String number) async {
      var url = 'tel:$number';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could Not Place Call";
      }
    }

    void email(String emailId) async {
      var url = 'mailto:${emailId}?subject=Request%20for%20Donation';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could Not Send email";
      }
    }

    void message(String number) async {
      var url = 'sms:${number}?body=Request%20for%20Donation';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could Not Send email";
      }
    }

    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 15.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 145.0,
            // width: MediaQuery.of(context).size.width / 2,
          ),
          Positioned(
            left: 15.0,
            top: 30.0,
            child: Container(
              height: 92.0,
              width: MediaQuery.of(context).size.width - 25.0,
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Positioned(
              left: 95.0,
              top: 56.0,
              child: Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3.0,
                          blurRadius: 3.0)
                    ]),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 25.0),
                        Icon(Icons.thumb_up,
                            color: Colors.green[700], size: 15.0),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              customHeader: Icon(FontAwesomeIcons.comments,
                                  size: 40, color: Colors.purple),
                              animType: AnimType.BOTTOMSLIDE,
                              tittle: 'sldkblkn',
                              desc: 'ldfnbkldfbn',
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Message",
                                      style: TextStyle(
                                          fontFamily: "Varela",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 10),
                                    child: TextField(
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.purple,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.edit),
                                        hintText:
                                            "Write an Optional Agreement Message",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      onChanged: (value) {
                                        msg = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                reqref.update(
                                    {'message': msg, 'status': 'accepted'});
                              },
                            )..show();
                          },
                          child: Text(
                            "Accept Request",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700]),
                          ),
                        ),
                        SizedBox(width: 25.0),
                        Icon(Icons.cancel, color: Colors.red, size: 15.0),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              tittle: 'sldkblkn',
                              desc: 'ldfnbkldfbn',
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Message",
                                      style: TextStyle(
                                          fontFamily: "Varela",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 10),
                                    child: TextField(
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.purple,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.edit),
                                        hintText:
                                            "Write a Optional Rejection Message",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      onChanged: (value) {
                                        rejmsg = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                reqref.update(
                                    {'message': rejmsg, 'status': 'rejected'});
                              },
                            )..show();
                          },
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Container(
            height: 105.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: CircularProfileAvatar(
                      imgurl,
                      animateFromOldImageOnUrlChange: true,
                      radius: 40,
                      onTap: () {
                        AwesomeDialog(
                          // btnOkColor: Colors.purple[400],
                          customHeader: CircularProfileAvatar(imgurl,
                              animateFromOldImageOnUrlChange: true, radius: 55),
                          context: context,
                          animType: AnimType.SCALE,
                          // dialogType: DialogType.INFO,
                          body: Column(
                            children: [
                              Text(
                                "Contact",
                                style: TextStyle(
                                    fontFamily: "Varela", fontSize: 20),
                              ),
                              Text(
                                username,
                                style: TextStyle(
                                    fontFamily: "Varela",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.phoneAlt,
                                        color: Colors.green[700],
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        makeCall(phone);
                                      },
                                    ),
                                    SizedBox(width: 15),
                                    IconButton(
                                      icon: Icon(
                                        Icons.message,
                                        color: Colors.amber,
                                        size: 38,
                                      ),
                                      onPressed: () {
                                        message(phone);
                                      },
                                    ),
                                    SizedBox(width: 15),
                                    IconButton(
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.red,
                                        size: 38,
                                      ),
                                      onPressed: () {
                                        email(emailid);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          btnOkOnPress: () {},
                        )..show();
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Text(
                        username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF563734),
                            fontFamily: 'Montserrat',
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: 260.0,
                        child: Text(
                          desc,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Varela',
                              fontSize: 11.0),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            fontFamily: 'Montserrat',
                            fontSize: 15.0),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
