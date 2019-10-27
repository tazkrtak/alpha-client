import 'package:equatable/equatable.dart';

class BalanceState extends Equatable {
  final double balance;
  final double chargedBalance;
  final String lastTransactionId;

  BalanceState({this.balance, this.chargedBalance, this.lastTransactionId})
      : super([balance, chargedBalance, lastTransactionId]);

  @override
  String toString() {
    return '''BalanceState {
       balance: $balance,
       chargedBalance: $chargedBalance,
       lastTransactionId: $lastTransactionId
    }''';
  }
}
