import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction.dart' as models;

class TransactionsRepository {
  static final Firestore _db = Firestore.instance;

  Stream<List<models.Transaction>> getTransactions(String userNationalId) {
    return _db
        .collection('transactions')
        .where('userNationalId', isEqualTo: userNationalId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => models.Transaction.fromDocument(doc))
          .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }
}
