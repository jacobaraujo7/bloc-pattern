import 'package:bloc_pattern/src/module.dart';
import 'package:flutter/material.dart';

import '../bloc_provider.dart';

void initModule(ModuleWidget module) {
  BlocProvider.isTest = true;
  var key = module.runtimeType.toString();
  var blocs = module.blocs;
  var dependencies = module.dependencies;
  BlocProvider.addCoreInit(blocs, dependencies, key);
}

void initModules(List<ModuleWidget> modules) {
  for (var module in modules) {
    initModule(module);
  }
}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
