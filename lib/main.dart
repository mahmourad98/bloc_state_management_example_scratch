import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:state_management/MyAppBlocDelegate.dart';
import 'app.dart';

void main(){
  BlocSupervisor.delegate = MyAppBlocDelegate();
  runApp(MyApp());
}
