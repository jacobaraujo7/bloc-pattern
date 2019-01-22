# Bloc Pattern

Provider to implement Bloc Pattern in your Flutter code

## Start


Add [`bloc_pattern`](https://pub.dartlang.org/packages/bloc_pattern) in your pubspec.yaml.

Create a Controller Bloc by implementing `BlocBase` and add its streams.
OBS: You can pass the "context" in the Bloc.

``` dart
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocController implements BlocBase {

BlocController();

//Stream that receives a number and changes the count;
var _counterController = BehaviorSubject<int>(seedValue: 0);
//output
Stream<int> get outCounter => _counterController.stream;
//input
Sink<int> get inCounter => _counterController.sink;

increment(){
    inCounter.add(_counterController.value+1);
}

@override
void dispose() {
    _counterController.close();
}

}

```

Add the Provider in the main widget of your widget tree by passing as your BlocController parameter

``` dart

...

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocController>(
      child: MaterialApp(
        home: MyHomePage(),
      ),
      bloc: BlocController(),
    );
  }
}

...

```

Now you can recover your Bloc anywhere in your widget tree with the help of `BlocProvider`

``` dart

@override
  Widget build(BuildContext context) {
    //recuperando seu Bloc
  final BlocController bloc = BlocProvider.of<BlocController>(context);

  ....


}

```

Now just use `StreamBuilder` to get your streams and change the UI without needing setState

``` dart

StreamBuilder(
    stream: bloc.outCounter,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Text(
        '${snapshot.data}',
        style: Theme.of(context).textTheme.display1,
    );
    },
),

  ....

floatingActionButton: new FloatingActionButton(
    onPressed: bloc.increment,
    tooltip: 'Increment',
    child: new Icon(Icons.add),
), 


}

```

## Para mais informações

Acesse o Blog do Flutterando Clicando [aqui](https://flutterando.com.br).

