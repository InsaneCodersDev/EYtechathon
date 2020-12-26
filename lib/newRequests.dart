// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaccinemgmt/globals.dart' as global;

class NewRequests extends StatefulWidget {
  @override
  _NewRequestsState createState() => _NewRequestsState();
}

class _NewRequestsState extends State<NewRequests>
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
    // Future.delayed(Duration(minutes: 2), () async {
    //   global.getrequests('ngouid');
    //   setState(() {});
    // });

    return Scaffold(
        backgroundColor: Colors.black87,
        body: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 190.0,
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
                  padding: EdgeInsets.only(top: 75.0, left: 15.0),
                  child: Text(
                    'YmS Charity',
                    style: TextStyle(
                        fontFamily: 'Satisfy',
                        fontSize: 45.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 135.0, left: 15.0),
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
                height: MediaQuery.of(context).size.height - 272,
                child: RefreshIndicator(
                    color: Colors.purple,
                    onRefresh: () async {
                      await global.getrequests('ngouid');
                      setState(() {});
                    },
                    child: GlowingOverscrollIndicator(
                      color: Colors.pink[600],
                      axisDirection: AxisDirection.down,
                      child: ListView(
                          padding: EdgeInsets.all(0), children: notilist),
                    ))),
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

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: Row(
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.check,
              size: 35,
            ),
            SizedBox(width: 5),
            Text(
              "Accept",
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Varella",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          alignment: Alignment.centerLeft,
          color: Colors.red,
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width - 125),
              Icon(
                FontAwesomeIcons.times,
                size: 30,
              ),
              Text(
                "Reject",
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: "Varella",
                  fontSize: 20,
                ),
              )
            ],
          )),
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, top: 15.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 75.0,
              width: MediaQuery.of(context).size.width - 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 4, 8, 4),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: CircularProfileAvatar(
                        imgurl,
                        animateFromOldImageOnUrlChange: true,
                        radius: 30,
                        onTap: () {
                          AwesomeDialog(
                            // btnOkColor: Colors.purple[400],
                            customHeader: CircularProfileAvatar(imgurl,
                                radius: 55,
                                animateFromOldImageOnUrlChange: true),
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
                    SizedBox(width: 15.0),
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
                          width: 200.0,
                          child: Text(
                            desc,
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Varela',
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      price.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontFamily: 'Montserrat',
                          fontSize: 17.0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          AwesomeDialog(
            context: context,
            customHeader:
                Icon(FontAwesomeIcons.comments, size: 40, color: Colors.purple),
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
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: TextField(
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      icon: Icon(Icons.edit),
                      hintText: "Write an Optional Agreement Message",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      msg = value;
                    },
                  ),
                ),
              ],
            ),
            btnCancelOnPress: () {
              setState(() {});
            },
            btnOkOnPress: () async {
              await reqref.update({'message': msg, 'status': 'accepted'});
              // setState(() {});
            },
          )..show();
        } else if (direction == DismissDirection.endToStart) {
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
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: TextField(
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      icon: Icon(Icons.edit),
                      hintText: "Write a Optional Rejection Message",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      rejmsg = value;
                    },
                  ),
                ),
              ],
            ),
            btnCancelOnPress: () {
              setState(() {});
            },
            btnOkOnPress: () {
              reqref.update({'message': rejmsg, 'status': 'rejected'});
              // setState(() {});
            },
          )..show();
        }
      },
    );
  }
}
