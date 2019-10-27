import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/user.dart';
import '../../repos/transaction_repository.dart';
import 'bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final User _user;
  StreamSubscription _transactionsSubscription;

  TransactionsBloc(this._user);

  @override
  TransactionsState get initialState => TransactionLoading();

  @override
  Stream<TransactionsState> mapEventToState(TransactionsEvent event) async* {
    if (event is LoadTransactions) {
      yield* _mapLoadTransactionsToState();
    } else if (event is UpdateTransactions) {
      yield TransactionsLoaded(event.transactions);
    }
  }

  Stream<TransactionsState> _mapLoadTransactionsToState() async* {
    _transactionsSubscription?.cancel();
    _transactionsSubscription = TransactionsRepository
        .getTransactions(_user.nationalId)
        .listen((transactions) => dispatch(UpdateTransactions(transactions)));
  }
}
