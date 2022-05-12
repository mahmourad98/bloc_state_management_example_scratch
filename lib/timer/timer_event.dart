import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class TimerEvent extends Equatable{
  const TimerEvent();

  @override
  List<Object> get props => <dynamic>[];
}

class TimerEventStart extends TimerEvent{
  final int duration;

  const TimerEventStart({@required this.duration});
}

class TimerEventPause extends TimerEvent{}

class TimerEventResume extends TimerEvent{}

class TimerEventReset extends TimerEvent{}

class TimerEventTick extends TimerEvent{
  final int duration;

  const TimerEventTick({@required this.duration});

  @override
  List<Object> get props => <int>[duration];
}
