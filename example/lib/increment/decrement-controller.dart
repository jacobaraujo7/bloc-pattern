import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class DecrementController extends BlocBase {
  DecrementController() {
    print("DecrementController create");
  }

  //fluxo da variavel counter
  var _counterController = BehaviorSubject<int>(seedValue: 0);
  Stream<int> get outCounter => _counterController.stream;
  Sink<int> get inCounter => _counterController.sink;

  void decrement() {
    inCounter.add(_counterController.value - 1);
  }

  @override
  void dispose() {
    print("DecrementController dispose");

    _counterController.close();
  }
}
