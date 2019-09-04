import 'package:bloc_pattern/src/inject.dart';
import 'package:bloc_pattern/src/injectable.dart';

class Dependency<T> extends Injectable<T> {
  Dependency(T Function(Inject i) inject, {bool singleton = true})
      : super(inject, singleton: singleton);
}
