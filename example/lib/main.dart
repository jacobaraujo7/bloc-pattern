import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'api/general_api.dart';
import 'increment/increment-controller.dart';
import 'increment/decrement-controller.dart';
import 'increment/increment-widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        home: IncrementWidget(),
      ),
      blocs: [
        Bloc(() => IncrementController()),
        Bloc(() => DecrementController())
      ],
      dependencies: [
        Dependency((i) => GeneralApi(i['name']), singleton: true),
      ],
    );
  }
}

