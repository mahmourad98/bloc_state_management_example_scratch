import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/timer/clock_ticker.dart';
import 'package:state_management/timer/timer_bloc.dart';

import 'counter_bloc.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider<CounterBloc>(
  //     create: (context) => CounterBloc(),
  //     child: MaterialApp(
  //       home: HomePage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(60, const ClockTicker(),),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(109, 234, 255, 1,),
          accentColor: Color.fromRGBO(72, 74, 126, 1,),
          brightness: Brightness.dark,
        ),
        home: HomePage(),
      ),
    );
  }
}