# Bloc Pattern
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6UTC2V72FL644&source=url)

Provider to implement Bloc Pattern with Dependency Injection

## Start

s
Add [`bloc_pattern`](https://pub.dartlang.org/packages/bloc_pattern) in your pubspec.yaml.

Create a Controller Bloc by implementing `BlocBase` and add its streams.

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
    return BlocProvider(
      child: MaterialApp(
        home: IncrementWidget(),
      ),
      blocs: [
        //add yours BLoCs controlles
        Bloc((i) => BlocController()),
      ],
    );
  }
}

...

```

Now you can recover your Bloc anywhere in your widget tree with the help of `BlocProvider`

``` dart

@override
  Widget build(BuildContext context) {
    //recovering your Bloc
  final BlocController bloc = BlocProvider.getBloc<BlocController>();

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

# Dependency Injection

Just like BLoC, you can also include in dependency injection other class. Ex: Services and Models

``` dart

...

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        home: IncrementWidget(),
      ),
      //add yours BLoCs controlles
       blocs: [
        Bloc((i) => IncrementController(i.get<GeneralApi>({"name":"John"}))),
        Bloc((i) => DecrementController())
      ],
      //add Other Object to provider
      dependencies: [
        Dependency((i) => GeneralApi(i.params['name'])),
      ],
    );
  }
}

...

```

You can define whether this dependency will behave as a singleton or not. Default is false.

For injection, use:

``` dart

@override
  Widget build(BuildContext context) {
   
    //recovering your API dependency
  final GeneralApi api = BlocProvider.getDependency<GeneralApi>();
  
  //Passing Data by Parameters
  final UserModel user = BlocProvider.getDependency<UserModel>({
    "id": 1,
    "name": "João"
  });
  ....
}

```

# Dispose

The data is automatically discarded when the application finishes, however if you want to do this manually or restart some injected singleton, use:

``` dart
//dispose BLoC
final BlocController bloc = BlocProvider.disposeBloc<BlocController>();

//dispose dependency
BlocProvider.disposeDependency<GeneralApi>();

```

Extend you Service or Repositore with Disposable for automatic dipose.

``` dart

class GeneralApi extends Disposable {

  @override
  void dispose(){
    //dispose Objects
  }
}

```

THAT´S ALL

## Para mais informações

Acesse o Blog do Flutterando Clicando [aqui](https://flutterando.com.br).
