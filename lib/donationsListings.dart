import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mydonationapp/item_detail.dart';
import 'package:mydonationapp/globals.dart' as global;
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Donations extends StatefulWidget {
  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends State<Donations>
    with SingleTickerProviderStateMixin {
  List<Widget> donorList = [];
  List<Widget> ngoList = [];
  List<Widget> userList = [];
  TabController tabController;
  @override
  void initState() {
    global.getdata();
    global.getdonations();
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    donorList = []; //Donot Remove at any cost.....!!!!!
    ngoList = [];
    userList = [];

    if (global.items.length != 0) {
      for (var item in global.items) {
        donorList.add(_buildDonationCard(
          context,
          item['itemcategory'],
          item['itemname'],
          int.parse(item['itemcount']),
          global.username,
          item['itemphoto'],
          item['itempickup'],
          item['uid'],
        ));
      }
    }

    if (global.type == 'donor') {
      for (var items in global.ngoitemlist) {
        for (var item in items) {
          ngoList.add(_buildDonationCard(
              context,
              item['itemcategory'],
              item['itemname'],
              int.parse(item['itemcount']),
              item['ngoname'] == null ? "" : item['ngoname'],
              item['itemphoto'],
              item['itempickup'],
              item['uid']));
        }
      }
      global.getall('ngo');
    } else {
      for (var items in global.donoritemlist) {
        for (var item in items) {
          ngoList.add(_buildDonationCard(
              context,
              item['itemcategory'],
              item['itemname'],
              int.parse(item['itemcount']),
              item['ngoname'] == null ? "" : item['ngoname'],
              item['itemphoto'],
              item["itempickup"],
              item['uid']));
        }
      }
      global.getall('donor');
    }

    if (global.userlist.length != 0) {
      for (var item in global.userlist) {
        userList.add(_userlist(item['img'], item['name'], item['email']));
      }
    }

    Future.delayed(Duration(seconds: 1), () async {
      global.getngodata();
      global.getdonations();
      ngoList.clear();
      setState(() {});
    });

    return Scaffold(
      // backgroundColor: Color(0xFFF9EFEB),
      backgroundColor: Colors.black87,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      // colors: [Color(0x000000), Color(0xBB923CB5)],
                      colors: [
                        Colors.purple[500], //Color(0xBB923CB5)
                        Color(0x21212),
                      ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(75.0)),
                  // color: Color(0xFFFD7465)),
                  // color: Colors.grey[900],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 65.0, left: 15.0),
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
                padding: EdgeInsets.only(top: 125.0, left: 15.0),
                child: Text(
                  'Donation Listings',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 180.0, left: 15.0, right: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                      )),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      hintText: 'Search for an item',
                      hintStyle:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 14.0),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              )
            ],
          ),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.purple, //Color(0xFFFE8A7E)
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4.0,
            isScrollable: true,
            labelColor: Colors.purple, //Color(0xFF440206)
            unselectedLabelColor: Colors.white, //Color(0xFF440206)
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Your Listings',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  global.type == 'donor'
                      ? 'NGO\'s Requests'
                      : 'Donor\'s Listings',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  global.type == 'donor' ? 'All NGOs' : 'All Donors',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            height: MediaQuery.of(context).size.height - 372,
            child: GlowingOverscrollIndicator(
              color: Colors.pink[600],
              axisDirection: AxisDirection.right,
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  GlowingOverscrollIndicator(
                    color: Colors.pink[600],
                    axisDirection: AxisDirection.down,
                    child: GridView.count(
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.9,
                        children: donorList),
                  ),
                  GlowingOverscrollIndicator(
                    color: Colors.pink[600],
                    axisDirection: AxisDirection.down,
                    child: GridView.count(
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.9,
                        children: ngoList),
                  ),
                  GlowingOverscrollIndicator(
                      color: Colors.pink[600],
                      axisDirection: AxisDirection.down,
                      child: ListView(
                          padding: EdgeInsets.all(0), children: userList)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDonationCard(BuildContext context, int category, String itemName,
      int qty, String name, String imgurl, String itemmssg, String uid) {
    List<dynamic> iconlist = [
      Icons.food_bank_rounded,
      Icons.checkroom,
      LineAwesomeIcons.gamepad,
      LineAwesomeIcons.medkit,
      Icons.electrical_services_rounded,
      LineAwesomeIcons.book,
      FontAwesomeIcons.heartbeat,
      FontAwesomeIcons.pencilAlt,
      FontAwesomeIcons.chair,
      LineAwesomeIcons.gift,
    ];

    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 22.0, bottom: 10.0, right: 22),
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetail(
                  imgurl: imgurl,
                  qty: qty.toString(),
                  cookiename: itemName,
                  username: name,
                  mssg: itemmssg,
                  uid: uid),
            ),
          ),
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 28.0, right: 15.0, top: 15.0, bottom: 10),
                    child: Icon(
                      iconlist[category],
                      color: Colors.grey[900],
                      size: 100,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                // width: 145.0,
                child: Text(
                  itemName,
                  style: TextStyle(
                      fontFamily: "Varela",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Qty: ' + qty.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Varela',
                      color: Colors.purple),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.account_box, color: Colors.purple, size: 15.0),
                      SizedBox(width: 5.0),
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _userlist(String imgurl, String username, String email) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 5.0, right: 15, bottom: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // height: 95.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircularProfileAvatar(
                      imgurl,
                      animateFromOldImageOnUrlChange: true,
                      radius: 25,
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 10.0),
                        Text(
                          username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Montserrat',
                              fontSize: 15.0),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: 260.0,
                          child: Text(
                            email,
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Varella',
                                fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
