import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Core {
  DateTime createdAt = DateTime.now();
  final Map<String, dynamic> _injectMapBloc = {};
  final Map<String, dynamic> _injectMapDependency = {};
  final Map<String, Widget> _injectMapView = {};

  final List<Bloc> blocs;
  final List<Dependency> dependencies;
  final List<Widget> views;
  final String tag;

  Core({this.blocs, this.dependencies, this.views, this.tag});

  bloc<T>([Map<String, dynamic> params]) {
    String typeBloc = T.toString();
    T blocBase;
    if (_injectMapBloc.containsKey(typeBloc)) {
      blocBase = _injectMapBloc[typeBloc];
    } else {
      Bloc b = blocs.firstWhere((b) => b.inject is T Function(Inject));
      blocBase = b.inject(Inject(params: params, tag: tag));
      if (b.singleton) {
        _injectMapBloc[typeBloc] = blocBase;
      }
    }
    return blocBase;
  }

  removeBloc<T>() {
    String type = T.toString();
    if (_injectMapBloc.containsKey(type)) {
      try {
        _injectMapBloc[type].dispose();
      } catch (e) {}
      _injectMapBloc.remove(type);
    }
  }

  removeDependency<T>() {
    String type = T.toString();
    if (_injectMapDependency.containsKey(type)) {
      if (_injectMapDependency[type] is Disposable)
        _injectMapDependency[type].dispose();
      _injectMapDependency.remove(type);
    }
  }

  dependency<T>([Map<String, dynamic> params]) {
    String typeBloc = T.toString();
    T dep;
    if (_injectMapDependency.containsKey(typeBloc)) {
      dep = _injectMapDependency[typeBloc];
    } else {
      Dependency d =
          dependencies.firstWhere((dep) => dep.inject is T Function(Inject));
      dep = d.inject(Inject(params: params, tag: tag));
      if (d.singleton) {
        _injectMapDependency[typeBloc] = dep;
      }
    }
    return dep;
  }

  Widget view(String key) {
    if (!_injectMapView.containsKey(key)) throw "View not found";
    return _injectMapView[key];
  }

  dispose() {
    for (String key in _injectMapBloc.keys) {
      var bloc = _injectMapBloc[key];
      if (bloc is Disposable || bloc is BlocBase || bloc is ChangeNotifier) {
        bloc.dispose();
      }
    }
    _injectMapBloc.clear();

    for (String key in _injectMapDependency.keys) {
      var dependency = _injectMapDependency[key];
      if (dependency is Disposable) dependency.dispose();
    }
    _injectMapDependency.clear();
  }
}
