import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:example/segunda-tela/segunda-tela.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class IncrementController extends BlocBase {
  final BuildContext context;
  IncrementController(this.context);

  //fluxo da variavel counter
  var counter = 0;
  var _counterController = BehaviorSubject<int>(seedValue: 0);
  Stream<int> get outCounter => _counterController.stream;
  Sink<int> get inCounter => _counterController.sink;

  nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SegundaTelaWidget()),
    );
  }

  void increment() {
    counter++;
    inCounter.add(_counterController.value + 1);
  }

  @override
  void dispose() {
    _counterController.close();
  }
}
