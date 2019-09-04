import 'package:bloc_pattern/src/inject.dart';

abstract class Injectable<T> {
  final T Function(Inject i) inject;
  final bool singleton;

  Injectable(this.inject, {this.singleton = true});
}
