import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/timer/timer_bloc.dart';
import 'package:state_management/timer/timer_event.dart';
import 'package:state_management/timer/timer_state.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomePage extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   var myCounterBloc = BlocProvider.of<CounterBloc>(context);
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Bloc Counter App'),
  //     ),
  //     body: Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           IconButton(
  //             icon: Icon(Icons.remove),
  //             onPressed: () {
  //               myCounterBloc.add(CounterEvent.remove);
  //             },
  //           ),
  //           BlocBuilder<CounterBloc, int>(
  //             builder: (context, state) {
  //               return Text('$state');
  //             },
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.add),
  //             onPressed: () {
  //               myCounterBloc.add(CounterEvent.add);
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final myTimerBloc = BlocProvider.of<TimerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer App'),
      ),
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: BlocBuilder<TimerBloc, TimerState>(
                    condition: (previousState, currentState) =>
                    currentState.runtimeType != previousState.runtimeType,
                    builder: (context, state) {
                      print("duration ${state.duration}");
                      final String minutesSection = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsSection = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$minutesSection:$secondsSection',
                        style: TextStyle(
                            fontSize: 65, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                condition: (previousState, currentState) =>
                currentState.runtimeType != previousState.runtimeType,
                builder: (context, state) => Actions(timerBloc: myTimerBloc,),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(184, 189, 245, 0.7)
          ],
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(172, 182, 219, 0.7)
          ],
          [
            Color.fromRGBO(72, 73, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(190, 238, 246, 0.7)
          ]
        ],
        durations: [19440, 10800, 6000],
        heightPercentages: [0.03, 0.01, 0.02],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, double.infinity),
      backgroundColor: Colors.blue[50],
    );
  }
}

class Actions extends StatelessWidget {
  final timerBloc;

  const Actions({Key key, @required this.timerBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _mapStateToActionButtons(),
    );
  }

  List<Widget> _mapStateToActionButtons() {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerStateReady) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            print("current state duration: ${currentState.duration}");
            timerBloc.add(TimerEventStart(duration: currentState.duration));
          },
        ),
      ];
    }
    if (currentState is TimerStateRunning) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () {
            timerBloc.add(TimerEventPause(),);
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(TimerEventReset(),);
          },
        )
      ];
    }
    if (currentState is TimerStatePaused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            timerBloc.add(TimerEventResume(),);
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(TimerEventReset(),);
          },
        )
      ];
    }
    if (currentState is TimerStateFinished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(TimerEventReset(),);
          },
        )
      ];
    }
    return [];
  }
}