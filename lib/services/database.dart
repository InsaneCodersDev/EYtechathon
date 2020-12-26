import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection service
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      {String name,
      String email,
      String type,
      String phone,
      String img}) async {
    return await userCollection.doc(uid).set(
      {
        'name': name,
        'email': email,
        'type': type,
        'phone': phone,
        'img': img,
      },
    );
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Future<bool> checkuservalid(String email) async {
    QuerySnapshot qs = await userCollection.get();
    Future<bool> val = Future.value(false);
    print("To check : " + email);
    qs.docs.forEach((element) {
      print(element.get('email').toString());
      if (element.get('email').toString() == email) {
        print(element.get('email').toString());
        val = Future.value(true);
      }
    });
    return await val;
  }

  Future<dynamic> checktype(String email, String toCompare) async {
    Future<dynamic> val;
    QuerySnapshot qShot = await userCollection.get();
    print("to check : " + email);
    qShot.docs.forEach((element) {
      print(element.get('email'));
      if (element.get('email') == email) {
        print("Found match");
        print("type of email is from db: " + element.get('type'));
        print("type from signin is : " + toCompare);
        if (element.get('type').toString() == toCompare) {
          print("Itssss sameee");
          print(val);
          val = Future.value(true);
          print(val);
        } else
          val = Future.value(false);
      }
    });
    return await val;
  }
}
