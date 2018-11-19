import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:example/increment/increment-controller.dart';
import 'package:example/terceira-tela/terceira-tela.dart';
import 'package:flutter/material.dart';

class SegundaTelaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final IncrementController bloc =
        BlocProvider.of<IncrementController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda tela'),
      ),
      body: StreamBuilder(
        stream: bloc.outCounter,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
              child: RaisedButton(
                  child: Text("valor do counter: ${snapshot.data}"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TerceiraTelaWidget()),
                    );
                  }));
        },
      ),
    );
  }
}
