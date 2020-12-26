import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:vaccinemgmt/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetail extends StatefulWidget {
  final assetPath, qty, cookiename, imgurl, username, mssg, uid;

  ItemDetail(
      {this.assetPath,
      this.qty,
      this.cookiename,
      this.imgurl,
      this.username,
      this.mssg,
      this.uid});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  double nos = 1.0;
  int orderqty = 1;
  @override
  Widget build(BuildContext context) {
    bool disabled = widget.username == global.username ? true : false;
    bool isngo = global.type == "ngo" ? true : false;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), //Color(0xFF545D68)
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Item Details',
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              widget.cookiename,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 15.0),
          Hero(
            tag: widget.assetPath == null ? widget.imgurl : widget.assetPath,
            child: widget.imgurl == null
                ? widget.assetPath.runtimeType == String
                    ? Image.asset(widget.assetPath,
                        height: 270.0, width: 200.0, fit: BoxFit.contain)
                    : Image.file(widget.assetPath,
                        height: 270.0, width: 200.0, fit: BoxFit.contain)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.network(widget.imgurl,
                        loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : Container(
                              height: 270,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.purple),
                                  backgroundColor: Colors.grey[900],
                                  strokeWidth: 5,
                                ),
                              ),
                            );
                    }, height: 270.0, fit: BoxFit.contain),
                  ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
              "Qty: " + widget.qty.toString(),
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[400]),
            ), //Color(0xFFF17532)
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(widget.username,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Varela', fontSize: 24.0)),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                widget.mssg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela', fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          disabled
              ? Center()
              : Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text("",
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Varela")),
                ),
          Slider(
            min: 0,
            max: disabled ? 100.0 : double.parse(widget.qty),
            divisions: disabled ? 100 : int.parse(widget.qty),
            activeColor: Colors.purple,
            inactiveColor: Colors.deepPurple[300],
            label: nos.toInt().toString(),
            value: nos,
            onChanged: (newnos) {
              setState(() {
                nos = newnos;
                orderqty = nos.toInt();
              });
            },
          ),
          Center(
            child: MaterialButton(
              onPressed: disabled
                  ? orderqty > 0
                      ? () async {
                          for (var item in global.items) {
                            if (item['itemname'] == widget.cookiename) {
                              item['itemcount'] = orderqty.toString();
                              global.userinst.update({'items': global.items});
                              break;
                            }
                          }
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new HomePage()));
                        }
                      : () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            tittle: "Are you Sure ?",
                            desc:
                                'The Listing will be Deleted and No longer be Visible to anyone.',
                            btnCancelOnPress: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => new HomePage()));
                            },
                            btnOkOnPress: () async {
                              for (var item in global.items) {
                                if (item['itemname'] == widget.cookiename) {
                                  global.items.remove(item);
                                  break;
                                }
                              }
                              global.userinst.update({'items': global.items});
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => new HomePage()));
                            },
                          )..show();
                        }
                  : () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: "Confirm Request",
                        desc: 'Are you sure you Want to Send this Request?',
                        btnCancelOnPress: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new HomePage()));
                        },
                        btnOkOnPress: () async {
                          await global.requestinst.doc().set({
                            'uid': global.uid,
                            'ngouid': widget.uid,
                            'ngoname': widget.username,
                            'quantity': orderqty.toString(),
                            'message': widget.mssg,
                            'status': 'pending',
                            'itemname': widget.cookiename,
                            'datetime': DateTime.now().toString(),
                          });
                          await Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new HomePage()));
                        },
                      )..show();
                    },
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: disabled
                        ? Colors.purple[900]
                        : Color.fromRGBO(49, 39, 79, 1)), //Color(0xFFF17532)
                child: Center(
                  child: Text(
                    disabled
                        ? orderqty == 0
                            ? "Delete"
                            : "Update ->  " + orderqty.toString()
                        : isngo
                            ? "Request Donation -> " + orderqty.toString()
                            : 'Donate -> ' + orderqty.toString(),
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
