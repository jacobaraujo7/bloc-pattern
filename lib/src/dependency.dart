class Dependency<T> {
  final T Function(Map<String, dynamic>) inject;
  final bool singleton;

  Dependency(this.inject, {this.singleton = false});
}
