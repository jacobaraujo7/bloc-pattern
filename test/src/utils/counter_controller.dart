
import 'package:bloc_pattern/bloc_pattern.dart';

class CounterController extends BlocBase {

  int counter = 0;

  changeValue(){
    counter = 100;
    notifyListeners();
  }

}