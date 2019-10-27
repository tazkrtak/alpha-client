import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  String id;
  String userNationalId;
  String issuer;
  double amount;
  Timestamp timestamp;

  Transaction({
    this.id,
    this.userNationalId,
    this.issuer,
    this.amount,
    this.timestamp,
  });

  factory Transaction.fromDocument(DocumentSnapshot doc) {
    return Transaction(
      id: doc['id'],
      userNationalId: doc['userNationalId'],
      issuer: doc['issuer'],
      amount: doc['amount'].toDouble(),
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userNationalId': userNationalId,
      'issuer': issuer,
      'amount': amount,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return '''Transaction{
      id: $id,
      userNationalId:$userNationalId,
      issuer:$issuer,
      amount: $amount,
      timestamp: $timestamp,
    }''';
  }
}
