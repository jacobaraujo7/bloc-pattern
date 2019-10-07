import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exampleinjector/module/third_module.dart';
import 'package:exampleinjector/second/second_widget.dart';
import 'decrement-controller.dart';
import 'package:flutter/material.dart';
import 'increment-controller.dart';

class IncrementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final IncrementController bloc =
        BlocProvider.getBloc<IncrementController>();
    final DecrementController blocDec =
        BlocProvider.getBloc<DecrementController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SecondWidget()));
            },
            icon: Icon(Icons.accessibility),
          ),
          FlatButton(
            child: Text("New Module"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ThirdModule()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.outCounter,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text("Tocou no botão add ${snapshot.data} vezes");
              },
            ),
            Consumer<DecrementController>(
              distinct: (oldValue, newValue) => newValue.counter != newValue.counter,
              builder: (context, value) {
                return Text("Tocou no botão add ${value.counter} vezes");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          bloc.increment();
          blocDec.decrement();
        },
      ),
    );
  }
}
