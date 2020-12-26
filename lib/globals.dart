import 'package:cloud_firestore/cloud_firestore.dart';

String imgurl;
String uid;
String username;
String type;
String authid;

String itemname = "";
String itempickup = "";
String itemcount = "1";
int itemcategory = 0;
String itemphoto = "";

var items = [];
var ngoitemlist = [];
var donoritemlist = [];
var requestlist = [];
var requestlistuser = [];
var userlist = [];

DocumentReference userinst;
CollectionReference requestinst;
DocumentSnapshot userdata;
CollectionReference ngoinst;
QuerySnapshot ngodata;
String calledfrom = "";

getdata() async {
  userdata = await userinst.get();
  imgurl = userdata.get('img');
  type = userdata.get('type');
  try {
    items = userdata.get('items');
  } catch (e) {
    print("No items for this account");
  }
  username = userdata.get('name');
}

getngodata() async {
  List ngoitems = new List();
  ngodata = await ngoinst.where('type', isEqualTo: 'ngo').get();
  for (var data in ngodata.docs) {
    try {
      if (data.data()['items'] != null) ngoitems.add(data.data()['items']);
    } catch (e) {
      // print(e);
    }
  }
  ngoitemlist = ngoitems;
}

getdonations() async {
  List donoritems = new List();
  ngodata = await ngoinst.where('type', isEqualTo: 'donor').get();
  for (var data in ngodata.docs) {
    try {
      if (data.data()['items'] != null) donoritems.add(data.data()['items']);
    } catch (e) {
      // print(e);
    }
  }
  donoritemlist = donoritems;
}

getrequests(String type) async {
  List requests = new List();
  var data = await requestinst.where(type, isEqualTo: uid).get();
  for (var d in data.docs) {
    // print(d.reference.path.split("/")[1]);
    DocumentSnapshot tmp = await ngoinst.doc(d['uid']).get();
    DocumentSnapshot pmt = await ngoinst.doc(d['ngouid']).get();
    requests.add({
      'ngoname': d['ngoname'],
      'message': d['message'],
      'ngouid': d['ngouid'],
      'uid': d['uid'],
      'quantity': d['quantity'],
      'status': d['status'],
      'img': tmp['img'],
      'username': tmp['name'],
      'email': tmp['email'],
      'phone': tmp['phone'],
      'itemname': d['itemname'],
      'donorname': pmt['name'],
      'donorimg': pmt['img'],
      'reqid': d.reference.path.split("/")[1],
      'reqref': d.reference,
      'datetime': d['datetime'],
      'id': d.reference.id
    });
  }
  requests.sort((a, b) {
    return -a['datetime'].compareTo(b['datetime']);
  });
  if (type == 'ngouid') {
    requestlist = requests;
  } else {
    requestlistuser = requests;
  }
}

cleardata() {
  imgurl = "";
  uid = "";
  username = "";
  type = "";

  itemname = "";
  itempickup = "";
  itemcount = "1";
  itemcategory = 0;
  itemphoto = "";

  items = [];
  // ngoitems = [];

  calledfrom = "";
}

getall(String type) async {
  List users = new List();
  var userdata = await ngoinst.where('type', isEqualTo: type).get();
  for (var data in userdata.docs) {
    try {
      // if (data.data()['items'] != null) ngoitems.add(data.data()['items']);
      users.add(data.data());
    } catch (e) {
      // print(e);
    }
  }
  userlist = users;
}
