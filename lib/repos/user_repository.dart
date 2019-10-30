import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../util/auth.dart';

class UserRepository {
  static final Auth _auth = Auth.instance;
  static final Firestore _db = Firestore.instance;

  static Future<void> signIn(String nationalId, String password) async {
    await _auth.signIn(nationalId, password);
  }

  static Future<void> signUp(User user) async {
    await _auth.signUp(user);
  }

  static Future<void> signOut() async {
    return _auth.signOut();
  }

  static Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }

  static Future<User> getUser() async {
    return await _auth.currentUser;
  }

  static Future<bool> isEmailUsed(String email) async {
    final docs = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }

  static Future<bool> isNationalIdUsed(String nationalId) async {
    var docs = await _db
        .collection('users')
        .where('nationalId', isEqualTo: nationalId)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }

  static Future<bool> isPhoneNumberUsed(String phoneNumber) async {
    var docs = await _db
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }
}
