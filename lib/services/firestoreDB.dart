import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:wartec_app/models/userInfo.dart';

class DBFuture {
  Future<String> createUser(UserModel user) async {
    final usersCollection = FirebaseFirestore.instance.collection("users");
    String retVal = "error";

    try {
      final userDocument = usersCollection.doc(user.id);
      await userDocument.set(user.toJson());
      print('UserCreated at ${userDocument.path} ...');
      retVal = "success";
    } catch (e) {
      print(e);
      retVal = e.toString();
    }

    return retVal;
  }

  Future<UserModel?> getUser(String userId) async {
    final usersCollection = FirebaseFirestore.instance.collection("users");
    print('userId:$userId');

    if (userId.isNotEmpty) {
      final userDoc = await usersCollection.doc(userId).get();
      if (!userDoc.exists) {
        print('We have no user with id :$userId in our database');
        return null;
      }

      final userData = userDoc.data();
      print('User found.\nData:\n$userData');

      return UserModel.fromJson(userData!);
    }
  }

  Future<String?> updateUser(String userId, String field, String link) async {
    final usersCollection = FirebaseFirestore.instance.collection("users");
    String retVal = "error";

    try {
      final _updateVal = {field: link};
      final userDocument = usersCollection.doc(userId);
      print('sent at $field : ${_updateVal[field]}');
      await userDocument.set(_updateVal, SetOptions(merge: true));
      retVal = "success";
    } catch (e) {
      print(e);
      retVal = e.toString();
    }
    return retVal;
  }
}
