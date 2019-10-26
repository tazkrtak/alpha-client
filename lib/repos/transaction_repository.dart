import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import '../models/transaction.dart';

class TransactionsRepository {
  static final firestore.Firestore _db = firestore.Firestore.instance;

  static Stream<List<Transaction>> getTransactions(String userNationalId) {
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

  static void setRechargeTransaction({
    String userNationalId,
    double balance,
    String issuer,
    double amount,
  }) async {
    firestore.WriteBatch batch = firestore.Firestore.instance.batch();

    var transactionRef = _db.collection('transactions').document();
    var transaction = Transaction(
        id: transactionRef.documentID,
        userNationalId: userNationalId,
        issuer: issuer,
        amount: amount,
        timestamp: firestore.Timestamp.now());

    batch.setData(transactionRef, transaction.toMap());

    var userRef = _db.collection('users').document(userNationalId);
    var chargedBalance = balance + amount;

    batch.updateData(userRef, {
      "balance": chargedBalance,
      "chargedBalance": chargedBalance,
      "lastTransactionId": transactionRef.documentID
    });

    batch.commit();
  }
}
