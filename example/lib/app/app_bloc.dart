import 'package:bloc_pattern/bloc_pattern.dart';

class AppBloc extends BlocBase {

  int counter = 1;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
