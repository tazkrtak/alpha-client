import 'package:equatable/equatable.dart';

import '../../models/transaction.dart';

abstract class TransactionsEvent extends Equatable {
  TransactionsEvent([List props = const []]) : super(props);
}

class LoadTransactions extends TransactionsEvent {
  @override
  String toString() => 'LoadTransactions';
}

class UpdateTransactions extends TransactionsEvent {
  final List<Transaction> transactions;

  UpdateTransactions(this.transactions) : super([transactions]);

  @override
  String toString() => 'UpdateTransactions { transactions: $transactions }';
}
