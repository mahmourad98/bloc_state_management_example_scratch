import 'package:flutter/cupertino.dart';

class ClockTicker{
  const ClockTicker();

  Stream<int> ticking({@required int ticks}){
    return Stream.periodic(
      Duration(seconds: 1),
      (x){
        int y = ticks - x - 1;
        print(y);
        return y;
      }
    ).take(ticks);
  }
}