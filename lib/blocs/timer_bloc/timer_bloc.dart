import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../util/ticker.dart';
import 'bloc.dart';

class TimerBloc extends Bloc<TimerEvent, int> {
  final int resetInterval;
  StreamSubscription<int> _subscription;

  TimerBloc(this.resetInterval);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      _subscription?.cancel();
      _subscription = Ticker.tick(event.duration).listen(
        (_) => dispatch(Tick()),
        onDone: () => dispatch(Start(resetInterval)),
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
