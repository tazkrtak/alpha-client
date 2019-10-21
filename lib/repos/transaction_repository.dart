import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import '../models/transaction.dart';

class TransactionsRepository {
  static final firestore.Firestore _db = firestore.Firestore.instance;

  Stream<List<Transaction>> getTransactions(String userNationalId) {
    return _db
        .collection('transactions')
        .where('userNationalId', isEqualTo: userNationalId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => Transaction.fromDocument(doc))
          .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }
}
