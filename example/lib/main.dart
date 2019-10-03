import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'api/general_api.dart';
import 'increment/increment-controller.dart';
import 'increment/decrement-controller.dart';
import 'increment/increment-widget.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'dart:io' show Platform;

void main() {

  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IncrementWidget(),
      ),
      blocs: [
        Bloc((i) => IncrementController(i.get<GeneralApi>({"name": "John"}))),
        Bloc((i) => DecrementController())
      ],
      dependencies: [
        Dependency((i) => GeneralApi(i.params['name'])),
      ],
    );
  }
}
