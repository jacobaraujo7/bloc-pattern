import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exampleinjector/api/general_api.dart';
import 'package:rxdart/rxdart.dart';

class IncrementController extends BlocBase {
  
  final GeneralApi api;

  IncrementController(this.api){
    
    print("IncrementController create ${api.name}");
  }

  //fluxo da variavel counter
  var counter = 0;
  var _counterController = BehaviorSubject.seeded(0);
  Stream<int> get outCounter => _counterController.stream;
  Sink<int> get inCounter => _counterController.sink;

  void increment() {
    counter++;
    inCounter.add(_counterController.value + 1);
  }

  @override
  void dispose() {
    super.dispose();
    print("IncrementController dispose");
    _counterController.close();
  }
}
