import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class Auth {
  static final Firestore _db = Firestore.instance;
  static final Auth _instance = Auth._();
  static FutureOr<User> _user;

  FutureOr<User> get currentUser async => await _user;

  static Auth get instance => _instance;

  Auth._();

  Future<void> signIn(String nationalId, String password) async {
    var doc = await _db.collection('users').document(nationalId).get();
    if (!doc.exists) throw AuthException("User not found");
    password == doc['password']
        ? _user = User.fromDocument(doc)
        : throw AuthException("Wrong credentials");
  }

  Future<void> signUp(User user) async {
    _db.collection('users').document(user.nationalId).setData(user.toMap());
    _user = user;
  }

  Future<void> signOut() {
    throw UnimplementedError("Implemnt Sign out Method in Auth!");
  }
}

class AuthException implements Exception {
  String message;

  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException{message: $message}';
  }
}
