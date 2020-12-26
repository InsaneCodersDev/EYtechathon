import 'package:flutter/material.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Widget> historylist = [];
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    historylist = [];
    int i = 0;
    global.requestlistuser.forEach((data) {
      historylist.add(_transactionlog(
          i.toString(),
          data['donorimg'],
          data['donorname'],
          data['itemname'],
          'Qty: ' + data['quantity'],
          data['status'],
          data['message'],
          data['id']));
      i++;
    });
    // Future.delayed(Duration(seconds: 10), () async {
    //   global.getrequests('uid');
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
                  height: 250.0,
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
                    'Transactions',
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
                        hintText: 'Search in Notifications',
                        hintStyle:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 14.0),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height - 295,
                child: GlowingOverscrollIndicator(
                  color: Colors.pink[600],
                  axisDirection: AxisDirection.down,
                  child: RefreshIndicator(
                    color: Colors.purple,
                    onRefresh: () async {
                      await global.getrequests('uid');
                      setState(() {});
                    },
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 22),
                      children: historylist,
                    ),
                  ),
                )),
            SizedBox(height: 10.0),
          ],
        ));
  }

  _transactionlog(String key, String imgurl, String username, String desc,
      String price, String status, String message, String id) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          alignment: Alignment.centerLeft,
          color: Colors.red,
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.delete,
                size: 35,
              ),
              Text(
                "Delete",
                style: TextStyle(
                    color: Colors.black87, fontFamily: "Varella", fontSize: 20),
              ),
              SizedBox(width: MediaQuery.of(context).size.width - 210),
              Icon(
                Icons.delete,
                size: 35,
              ),
              Text(
                "Delete",
                style: TextStyle(
                    color: Colors.black87, fontFamily: "Varella", fontSize: 20),
              )
            ],
          )),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                // height: 95.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: status == "pending"
                      ? Colors.yellow[50]
                      : status == "rejected"
                          ? Colors.red[50]
                          : Colors.teal[100],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 8),
                  child: Row(
                    children: <Widget>[
                      CircularProfileAvatar(
                        imgurl,
                        animateFromOldImageOnUrlChange: true,
                        radius: 25,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            desc,
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
                              message,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Varella',
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontFamily: 'Montserrat',
                                fontSize: 12.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Warning',
          desc:
              'Are you sure you want to permanently delete this transaction\'s record ?',
          btnCancelOnPress: () {
            setState(() {});
          },
          btnOkOnPress: () {
            global.requestinst.doc(id).delete();
          },
        )..show();
      },
    );
  }
}
