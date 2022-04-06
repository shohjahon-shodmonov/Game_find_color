import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());

  String text = "This is the sample text for Flutter TextScroll widget. ";
  Color color = Colors.blue;
  List data = [];
  List tekshir = [];

  bool start = true;
  int random = 0;
  int natija = 0;
  int timeCount = 5;
  List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.brown
  ];
  List<String> names = ["GREEN", "RED", "YELLOW", "BLUE", "BROWN"];

  void rangTanla(index) {
    if (index == random) {
      emit(TextState());
      random = Random().nextInt(5);
      natija += 1;
      timeCount = 5;
      timeGame();
    } else {
      start = true;
      emit(TextState());
    }
  }

  void startGame() {
    start = false;
    natija = 0;
    emit(TextState());
  }

  timeGame(){
    for (var i = 0; i < 5; i++) {
      Future.delayed(Duration(seconds: i)).then((value){
        timeCount --;
        emit(TextState());
      });
    }
  }

  void textChange(List name) {
    data = text.split("");
    print(data);
    for (var i = 0; i < data.length; i++) {
      if (data[i] == name[i]) {
        color = Colors.green;
        emit(TextState());
      } else {
        color = Colors.red;
        emit(TextState());
      }
    }
    emit(TextState());
  }

  void refresh() {
    data.clear();
    color = Colors.blue;
    emit(TextState());
  }
}
