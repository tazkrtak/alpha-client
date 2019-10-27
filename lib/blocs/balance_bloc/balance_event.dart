import 'package:equatable/equatable.dart';
import '../../models/transaction.dart';

abstract class BalanceEvent extends Equatable {
  BalanceEvent([List props = const []]) : super(props);
}

class Update extends BalanceEvent {
  final Transaction transaction;

  Update(this.transaction) : super([transaction]);

  @override
  String toString() => 'Update { transaction: $transaction }';
}

class Recharge extends BalanceEvent {
  final double amount;

  Recharge(this.amount) : super([amount]);

  @override
  String toString() => 'Recharge { amount: $amount }';
}
