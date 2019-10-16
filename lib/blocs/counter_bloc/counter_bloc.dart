import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

abstract class CounterBloc extends Bloc<CounterEvent, int> {
  int _minValue;
  int _maxValue;

  CounterBloc(this._minValue, this._maxValue);

  @override
  int get initialState => _minValue;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState < _maxValue ? currentState + 1 : _maxValue;
        break;
      case CounterEvent.decrement:
        yield currentState > _minValue ? currentState - 1 : _minValue;
        break;
    }
  }
}

class QuantityBloc extends CounterBloc {
  static int minValue = 1;
  static int maxValue = 50;
  QuantityBloc() : super(minValue, maxValue);
}

class FeesBloc extends CounterBloc {
  static int minValue = 3;
  static int maxValue = 10;
  FeesBloc() : super(minValue, maxValue);
}
