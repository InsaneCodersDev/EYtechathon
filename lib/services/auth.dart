import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mydonationapp/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mydonationapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydonationapp/globals.dart' as global;

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  dynamic uid, name, img, phone, email;
  //create user obj based on firebase user
  User _userFromFirebaseUser(auth.User user) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      img = user.photoURL;
      phone = user.phoneNumber;
      email = user.email;

      name = name == null ? "" : name;
      email = email == null ? "" : email;
      img = img == null ? "" : img;
      return User(uid: uid, name: name, img: img, phone: phone, email: email);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<User> get user {
    return _auth
        .authStateChanges()
        .map((auth.User user) => _userFromFirebaseUser(user));
  }

  //sign in with anon
  Future signInAnon() async {
    try {
      auth.UserCredential result = await _auth.signInAnonymously();
      auth.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email password
  Future registerWithEmailAndPassword(
      String email, String password, bool type) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;

      //create a new document for the user
      String newtype = type == true ? "donor" : "ngo";
      await DatabaseService(uid: user.uid)
          .updateUserData(email: user.email, type: newtype);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //signin with email password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //signin with google
  Future googleSignIn(bool type) async {
    try {
      GoogleSignInAccount googleuser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleauth = await googleuser.authentication;
      auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken, idToken: googleauth.idToken);
      auth.UserCredential result = await _auth.signInWithCredential(credential);
      auth.User user = result.user;
      DatabaseService db = DatabaseService(uid: user.uid);
      if (type == null) {
        bool val = await db.checkuservalid(user.email);
        print("Data from db login : " + val.toString());
        if (val == false) {
          print("Entered false...");
          await signOut();
          return null;
        }
      } else {
        String newtype = type == true ? "donor" : "ngo";
        dynamic val = await db.checktype(user.email, newtype);
        print("value from db is " + val.toString());
        if (val == null) {
          DatabaseService(uid: user.uid).updateUserData(
              email: user.email,
              name: user.displayName,
              phone: user.phoneNumber,
              img: user.photoURL,
              type: newtype);
        } else if (val == false) {
          await signOut();
          return null;
        }
      }
      global.imgurl = user.photoURL;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      global.cleardata();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
