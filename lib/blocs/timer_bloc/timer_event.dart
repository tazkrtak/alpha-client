import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class Start extends TimerEvent {
  final int duration;

  Start(this.duration) : super([duration]);

  @override
  String toString() => 'StartEvent{duration: $duration}';
}

class Tick extends TimerEvent {
  @override
  String toString() => 'TickEvent';
}
