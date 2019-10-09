import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tazkrtak/models/user.dart';

class UserRepository {
  // TODO: Give Firestore a user instance and get one while fetching.
  // TODO: Don't use Singleton User, use a local variable instead.

  static Future<void> signIn(String nationalId, String password) async {
    DocumentSnapshot snap =
        await Firestore.instance.collection('users').document(nationalId).get();

    // TODO: Confirm passwords match and return result True/False
    // TODO: Save to SharedPref

    User().name = snap['name'];
    User().email = snap['email'];
    User().password = snap['password'];
    User().nationalId = snap['national ID'];
    User().phoneNumber = snap['phone number'];
  }

  static Future<void> signUp(
      {String nationalId,
      String password,
      String name,
      String email,
      String phoneNumber}) async {
    // TODO: Save to SharedPref

    return await Firestore.instance
        .collection('users')
        .document(nationalId)
        .setData({
      'name': name,
      'email': email,
      'national ID': nationalId,
      'phone number': phoneNumber,
      'password': password
    });
  }

  static Future<void> signOut() async {
    // TODO: Remove from SharedPref
    return print('Sign out here');
  }

  static Future<bool> isSignedIn() async {
    // TODO: Check existence in SharedPref
    return false;
  }

  static Future<User> getUser() async {
    return User();
  }
}
