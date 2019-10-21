import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String phoneNumber;
  String nationalId;
  String password;
  double balance;
  String secret;

  User({
    this.name,
    this.email,
    this.phoneNumber,
    this.nationalId,
    this.password,
    this.balance,
    this.secret,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      name: doc['name'],
      email: doc['email'],
      phoneNumber: doc['phoneNumber'],
      nationalId: doc['nationalId'],
      password: doc['password'],
      balance: doc['balance'].toDouble(),
      secret: doc['secret'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
      'password': password,
      'balance': balance,
      'secret': secret,
    };
  }

  @override
  String toString() {
    return '''User{
      name: $name,
      email: $email,
      phoneNumber: $phoneNumber,
      nationalId: $nationalId,
      password: $password,
      balance: $balance,
      secret: $secret
    }''';
  }
}
