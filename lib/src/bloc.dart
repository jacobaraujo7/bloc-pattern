import 'package:bloc_pattern/src/bloc_base.dart';

class Bloc<T extends BlocBase> {
  
  final T Function() inject;
  
  Bloc(this.inject);


}