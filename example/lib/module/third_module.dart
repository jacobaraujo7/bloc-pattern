import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:exampleinjector/api/general_api.dart';
import 'package:exampleinjector/increment/decrement-controller.dart';
import 'package:exampleinjector/increment/increment-controller.dart';
import 'package:flutter/material.dart';

// class ThirdModule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       tagText: "third",
//       child: ThirdWidget(),
//       blocs: [
//         Bloc((i) => IncrementController(i.get<GeneralApi>({"name":"David"}))),
//         Bloc((i) => DecrementController())
//       ],
//       dependencies: [
//         Dependency((i) => GeneralApi(i.params['name'])),
//       ],
//     );
//   }
// }

class ThirdModule extends ModuleWidget {
  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc((i) => IncrementController(i.get<GeneralApi>({"name": "David"}))),
        Bloc((i) => DecrementController())
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => GeneralApi(i.params['name'])),
      ];

  @override
  Widget get view => ThirdWidget();

  static Inject get to => Inject<ThirdModule>.of();

}

class ThirdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementController bloc = ThirdModule.to.getBloc<IncrementController>();

    final DecrementController blocDec =
        ThirdModule.to.getBloc<DecrementController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
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
