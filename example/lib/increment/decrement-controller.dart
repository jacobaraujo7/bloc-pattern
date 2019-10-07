
import 'package:bloc_pattern/bloc_pattern.dart';

class DecrementController extends BlocBase {
  DecrementController() {
    print("DecrementController create");
  }

  int counter = 0;

  void decrement() {
    counter--;
    notifyListeners();
  }

}
