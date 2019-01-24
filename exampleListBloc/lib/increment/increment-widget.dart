import 'package:bloc_pattern/bloc_pattern.dart';
import '../segunda-tela/segunda-tela.dart';
import 'decrement-controller.dart';
import 'package:flutter/material.dart';
import 'increment-controller.dart';

class IncrementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementController bloc =
    BlocProviderList.of<IncrementController>(context);

    final DecrementController blocDec =
    BlocProviderList.of<DecrementController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SegundaTelaWidget()),
              );
            },
          )
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
            StreamBuilder(
              stream: blocDec.outCounter,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text("Tocou no botão add ${snapshot.data} vezes");
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
