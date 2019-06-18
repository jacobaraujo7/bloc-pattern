class ComponentModel {
  String model(String name) => '''
  import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocController extends BlocBase {



//dispose will be called automatically by closing its streams
@override
void dispose() {
  super.dispose();
}

}
  ''';
}