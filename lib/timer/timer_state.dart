import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable{
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props {
    return <int>[duration];
  }
}

class TimerStateReady extends TimerState{
  TimerStateReady(int duration) : super(duration);
}

class TimerStateRunning extends TimerState{
  TimerStateRunning(int duration) : super(duration);
}

class TimerStatePaused extends TimerState{
  TimerStatePaused(int duration) : super(duration);
}

class TimerStateFinished extends TimerState{
  TimerStateFinished({int duration = 0}) : super(duration);

  @override
  List<Object> get props {
    return <int>[duration];
  }
}