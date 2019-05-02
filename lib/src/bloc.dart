import 'package:bloc_pattern/src/bloc_base.dart';
import 'package:bloc_pattern/src/inject.dart';

class Bloc<T extends BlocBase> {
  
  final T Function(Inject i) inject;
  
  Bloc(this.inject);


}