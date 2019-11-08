import 'package:bloc_pattern/src/inject.dart';

class Bloc<T> {
  final T Function(Inject i) inject;
  final bool singleton;

  Bloc(this.inject, {this.singleton = true});
}
