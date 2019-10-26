import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/user.dart';
import '../../repos/transaction_repository.dart';

import 'bloc.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final User user;

  BalanceBloc(this.user);

  @override
  BalanceState get initialState => BalanceState();

  @override
  Stream<BalanceState> mapEventToState(BalanceEvent event) async* {
    if (event is Update) {
      yield* _mapUpdateToState(event);
    } else if (event is Recharge) {
      TransactionsRepository.setRechargeTransaction(
        userNationalId: user.nationalId,
        balance: user.balance,
        issuer: "Tazkrtak",
        amount: event.amount,
      );
    }
  }

  Stream<BalanceState> _mapUpdateToState(Update event) async* {
    bool isNewTransaction = event.transaction.id != user.lastTransactionId;
    if (!isNewTransaction) return;

    bool isRechargeTransaction = event.transaction.amount > 0;
    if (isRechargeTransaction) {
      yield BalanceState(
        balance: event.transaction.amount + user.balance,
        chargedBalance: event.transaction.amount + user.balance,
        lastTransactionId: event.transaction.id,
      );
    } else {
      yield BalanceState(
        balance: user.balance + event.transaction.amount,
        chargedBalance: user.chargedBalance,
        lastTransactionId: event.transaction.id,
      );
    }
  }
}
