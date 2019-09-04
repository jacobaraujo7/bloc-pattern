import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_pattern/src/injectable.dart';
import 'package:flutter/material.dart';

class Core {
  final Map<String, dynamic> _injectMap = {};
  final Map<String, Widget> _injectMapView = {};

  final List<Injectable> injectables;
  final List<Widget> views;

  final String tag;
  Core({this.injectables, this.tag, this.views});

  T getInjectable<T>([Map<String, dynamic> params]) {
    String type = _typeOf<T>();
    T dependency;

    if (exist(type)) {
      dependency = _injectMap[type];
    } else {
      Injectable injectable =
          injectables.firstWhere((b) => b.inject is T Function(Inject));

      dependency = injectable.inject(Inject(params: params, tag: tag));

      if (injectable.singleton) {
        _injectMap[type] = dependency;
      }
    }
    return dependency;
  }

  String _typeOf<T>() => T.toString();

  bool exist(String type) {
    return _injectMap.containsKey(type);
  }

  void _removeByStringType(String existenType) {
    var dependency = _injectMap[existenType];
    if (dependency is Disposable) dependency.dispose();
    _injectMap.remove(existenType);
  }

  void remove<T>() {
    String type = _typeOf<T>();

    if (exist(type)) {
      _removeByStringType(type);
    }
  }

  Widget view(String key) {
    if (!_injectMapView.containsKey(key)) throw "View not found";
    return _injectMapView[key];
  }

  void dispose() {
    _injectMap.forEach((key, _) => _removeByStringType(key));
    _injectMap.clear();
  }
}
