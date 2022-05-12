import 'package:bloc/bloc.dart';

class MyAppBlocDelegate extends BlocDelegate{
  MyAppBlocDelegate();

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //print(event);
  }
}