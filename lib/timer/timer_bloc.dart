import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:state_management/timer/clock_ticker.dart';
import 'package:state_management/timer/timer_event.dart';
import 'package:state_management/timer/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState>{
  final int _duration;
  final ClockTicker _clockTicker;
  StreamSubscription<int> _tickerStreamSubscription;
  TimerBloc(this._duration, this._clockTicker);

  @override
  TimerState get initialState => TimerStateReady(this._duration);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async*{
   if(event is TimerEventStart){
    yield TimerStateRunning(event.duration);
    _tickerStreamSubscription?.cancel();
    _tickerStreamSubscription = this._clockTicker.ticking(ticks: state.duration)
    .listen(
      (duration) {
        //print("event: $event");
        add(TimerEventTick(duration: duration));
      }
    );
   }
   else if(event is TimerEventPause){
      if (state is TimerStateRunning) {
        _tickerStreamSubscription.pause();
        yield TimerStatePaused(state.duration);
      }
   }
   else if(event is TimerEventResume){
     if (state is TimerStatePaused) {
       _tickerStreamSubscription.resume();
       yield TimerStateRunning(state.duration);
     }
   }
   else if(event is TimerEventReset) {
     if (state is TimerStateRunning) {
       _tickerStreamSubscription?.cancel();
       yield TimerStateReady(state.duration);
     }
     else if (state is TimerStatePaused) {
       _tickerStreamSubscription?.cancel();
       yield TimerStateReady(state.duration);
     }
   }
   else if(event is TimerEventTick) {
      yield (event.duration > 0) ? TimerStateRunning(event.duration) : TimerStateFinished();
   }
  }

  @override
  Future<void> close() {
    _tickerStreamSubscription?.cancel();
    return super.close();
  }
}