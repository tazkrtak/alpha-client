import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';
import '../../models/user.dart';
import '../../repos/transaction_repository.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final User _user;
  final TransactionsRepository _transactionsRepository;
  StreamSubscription _transactionsSubscription;

  TransactionsBloc(this._user, this._transactionsRepository);

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
    _transactionsSubscription = _transactionsRepository
        .getTransactions(_user.nationalId)
        .listen((transactions) => dispatch(UpdateTransactions(transactions)));
  }
}