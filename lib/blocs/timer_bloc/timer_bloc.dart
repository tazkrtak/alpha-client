import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../util/ticker.dart';
import 'bloc.dart';

class TimerBloc extends Bloc<TimerEvent, int> {
  final Ticker ticker;
  final int startDuration;
  final int resetDuration;

  Stream<int> _stream;
  StreamSubscription<int> _subscription;

  TimerBloc(this.ticker, this.startDuration, this.resetDuration);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(TimerEvent event) async* {
    switch (event) {
      case TimerEvent.Start:
      case TimerEvent.Reset:
        int duration =
            event == TimerEvent.Start ? startDuration : resetDuration;
        _stream = ticker.tick(duration);
        _subscription?.cancel();
        _subscription = _stream.listen((_) => dispatch(TimerEvent.Tick));
        yield duration;
        break;
      case TimerEvent.Tick:
        yield currentState > 0 ? currentState - 1 : 0;
        break;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
