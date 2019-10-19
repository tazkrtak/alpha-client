import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class StartEvent extends TimerEvent {
  final int duration;

  StartEvent(this.duration) : super([duration]);

  @override
  String toString() {
    return 'StartEvent{duration: $duration}';
  }
}

class TickEvent extends TimerEvent {
  @override
  String toString() {
    return 'TickEvent';
  }
}
