import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../util/ticker.dart';
import 'bloc.dart';

class TimerBloc extends Bloc<TimerEvent, int> {
  final Ticker ticker;
  final int resetDuration;
  StreamSubscription<int> _subscription;

  TimerBloc(this.ticker, this.resetDuration);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(TimerEvent event) async* {
    if (event is StartEvent) {
      _subscription?.cancel();
      _subscription = ticker.tick(event.duration).listen(
            (_) => dispatch(TickEvent()),
            onDone: () => dispatch(StartEvent(resetDuration)),
          );
      yield event.duration;
    } else {
      yield currentState > 0 ? currentState - 1 : 0;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
