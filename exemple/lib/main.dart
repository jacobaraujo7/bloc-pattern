import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exemple/increment/increment-controller.dart';
import 'package:exemple/increment/increment-widget.dart';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<IncrementController>(
        child: IncrementWidget(),
        bloc: IncrementController(),
      ),
    );
  }
}
