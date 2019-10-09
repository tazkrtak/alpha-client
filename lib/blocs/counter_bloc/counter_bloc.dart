import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

abstract class CounterBloc extends Bloc<CounterEvent, int> {
  int _minValue = 0;

  CounterBloc(this._minValue);

  @override
  int get initialState => _minValue;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState >= _minValue + 1 ? currentState - 1 : _minValue;
        break;
    }
  }
}

class QuantityBloc extends CounterBloc {
  QuantityBloc() : super(1);
}

class FeesBloc extends CounterBloc {
  FeesBloc() : super(3);
}