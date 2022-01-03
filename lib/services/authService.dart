import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:wartec_app/models/userInfo.dart';
import 'package:wartec_app/services/firestoreDB.dart';
import 'package:wartec_app/utils/storage.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<AuthModel> get user {
  //   return _auth.onAuthStateChanged.map(
  //     (FirebaseUser firebaseUser) => (firebaseUser != null)
  //         ? AuthModel.fromFirebaseUser(user: firebaseUser)
  //         : null,
  //   );
  // }
  String? userLoggedIn() {
    var uid;
    final user = _auth.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return uid;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String fullName, String ktpNumber,
      String phoneNumber, String dob) async {
    String retVal = "error";
    try {
      final user = _auth.currentUser;
      UserModel _user = UserModel(
          id: user!.uid,
          email: email,
          fullName: fullName.trim(),
          ktpNumber: ktpNumber,
          phoneNumber: phoneNumber,
          dob: dob);
      String _returnString = await DBFuture().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      storage.write("userID", user.user!.uid);
      storage.write("userEmail", user.user!.email);
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
