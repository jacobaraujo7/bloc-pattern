import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exampleinjector/increment/increment-controller.dart';
import 'package:flutter/material.dart';

class SecondWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    IncrementController bloc = BlocProvider.getBloc<IncrementController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.outCounter,
          builder: (context, snapshot) {
            return Text("${snapshot.data}");
          },
        ),
      ),
    );
  }
}
