import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends BlocBase {

  final controller = BehaviorSubject<int>();


  @override
  void dispose() {
    super.dispose();
    controller.close();

  }

}