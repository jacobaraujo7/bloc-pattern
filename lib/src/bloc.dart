import 'package:bloc_pattern/src/bloc_base.dart';
import 'package:bloc_pattern/src/inject.dart';
import 'package:bloc_pattern/src/injectable.dart';

class Bloc<T extends BlocBase> extends Injectable<T> {
  Bloc(T Function(Inject i) inject, {bool singleton = true})
      : super(inject, singleton: singleton);
}
