import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

abstract class CounterBloc<T extends num> extends Bloc<CounterEvent, T> {
  T _minValue;
  T _maxValue;
  T _step;

  CounterBloc(this._minValue, this._maxValue, this._step);

  @override
  T get initialState => _minValue;

  @override
  Stream<T> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState < _maxValue ? currentState + _step : _maxValue;
        break;
      case CounterEvent.decrement:
        yield currentState > _minValue ? currentState - _step : _minValue;
        break;
    }
  }
}

class QuantityBloc extends CounterBloc<int> {
  static int minValue = 1;
  static int maxValue = 50;
  static int step = 1;

  QuantityBloc() : super(minValue, maxValue, step);
}

class FeesBloc extends CounterBloc<double> {
  static double minValue = 3;
  static double maxValue = 10;
  static double step = 0.5;

  FeesBloc() : super(minValue, maxValue, step);
}
