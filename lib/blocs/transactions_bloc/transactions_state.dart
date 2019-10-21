import 'package:equatable/equatable.dart';

import '../../models/transaction.dart';

abstract class TransactionsState extends Equatable {
  TransactionsState([List props = const []]) : super(props);
}

class TransactionLoading extends TransactionsState {
  @override
  String toString() => 'TransactionLoading';
}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactions;

  TransactionsLoaded(this.transactions) : super([transactions]);

  @override
  String toString() => 'TransactionsLoaded { Transactions: $transactions }';
}

class TransactionsNotLoaded extends TransactionsState {
  @override
  String toString() => 'TransactionsNotLoaded';
}
