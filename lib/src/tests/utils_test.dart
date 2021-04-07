import 'package:bloc_pattern/src/module.dart';
import 'package:flutter/material.dart';

import '../bloc_provider.dart';
import '../bloc.dart';
import '../dependency.dart';

void initModule(ModuleWidget module, {List<Bloc>? changeBloc, List<Dependency>? changeDependencies}) {
  BlocProvider.isTest = true;
  BlocProvider.debugMode = false;
  var key = module.runtimeType.toString();
  var blocs = module.blocs;
  var dependencies = module.dependencies;

  if (changeDependencies != null) {
    for (var item in changeDependencies) {
      var dep = dependencies.firstWhere((dep) {
        return item.inject.runtimeType == dep.inject.runtimeType;
      }, orElse: () => EmptyDependency());
      if (dep is! EmptyDependency) {
        dependencies.remove(dep);
        dependencies.add(item);
      }
    }
  }
  if (changeBloc != null) {
    for (var item in changeBloc) {
      //blocs.firstWhere((b) => b.inject is T Function(Inject));
      var dep = changeBloc.firstWhere((dep) {
        return item.inject.runtimeType == dep.inject.runtimeType;
      }, orElse: () => EmptyBloc());
      if (dep is! EmptyBloc) {
        changeBloc.remove(dep);
        changeBloc.add(item);
      }
    }
  }
  BlocProvider.addCoreInit(blocs, dependencies, key);
}

void initModules(List<ModuleWidget> modules, {List<Bloc>? changeBloc, List<Dependency>? changeDependencies}) {
  for (var module in modules) {
    initModule(module, changeBloc: changeBloc, changeDependencies: changeDependencies);
  }
}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
