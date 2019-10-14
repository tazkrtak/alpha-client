import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Auth {
  static const _NATIONAL_ID = 'nationalId';
  static const _PASSWORD = 'password';

  static final Firestore _db = Firestore.instance;
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static final Auth _instance = Auth._();
  static FutureOr<User> _user;

  FutureOr<User> get currentUser async {
    if (_user == null) {
      var data = await _getPrefs();
      if (data.containsKey(_NATIONAL_ID) && data.containsKey(_PASSWORD)) {
        await _fetchData(data[_NATIONAL_ID], data[_PASSWORD]);
      }
    }

    return await _user;
  }

  static Auth get instance => _instance;

  Auth._();

  Future<void> signIn(String nationalId, String password) async {
    String encryptedPassword = _encrypt(password);
    await _fetchData(nationalId, encryptedPassword);

    await _setPrefs(nationalId, encryptedPassword);
  }

  Future<void> signUp(User user) async {
    user.password = _encrypt(user.password);
     _user = user;
    await _getDocRef(user.nationalId).setData(user.toMap());
    await _setPrefs(user.nationalId, user.password);
  }

  Future<void> signOut() async {
    _user = null;
    await _setPrefs(null, null);
  }

  Future<Map<String, String>> _getPrefs() async {
    var prefs = await _prefs;
    return {
      _NATIONAL_ID: prefs.getString(_NATIONAL_ID),
      _PASSWORD: prefs.getString(_PASSWORD)
    };
  }

  Future<void> _setPrefs(String nationalId, String password) async {
    var prefs = await _prefs;
    prefs.setString(_NATIONAL_ID, nationalId);
    prefs.setString(_PASSWORD, password);
  }

  DocumentReference _getDocRef(String nationalId) {
    return _db.collection('users').document(nationalId);
  }

  Future<void> _fetchData(String nationalId, String encryptedPassword) async {
    var doc = await _getDocRef(nationalId).get();
    if (!doc.exists) throw AuthException("User not found");
    encryptedPassword == doc['password']
        ? _user = User.fromDocument(doc)
        : throw AuthException("Wrong credentials");
  }

  String _encrypt(String password) {
    return sha512.convert(utf8.encode(password)).toString();
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
