# Bloc Pattern
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6UTC2V72FL644&source=url)

Tools to implement BLoC Pattern with Dependency Injection in your project  

## Start

Add [`bloc_pattern`](https://pub.dartlang.org/packages/bloc_pattern) in your pubspec.yaml.

## Install in Flutter Web


Temporarily, the codes for flutter_web have been separated from the main package. But in the future they will be one.
To use the bloc_pattern in flutter_web add in your pubspec:

```
dependencies:
  bloc_pattern:
    git:
      url: https://github.com/jacobaraujo7/bloc-pattern.git
      ref: web
```

# Using

## BLoC class

Create the business logic class and extend to BlocBase

``` dart
import 'package:bloc_pattern/bloc_pattern.dart';

class ValueBloc extends BlocBase {
  double value = 0.0;

  onChangeValue(double v) {
    value = v;
    notifyListeners();
  }
}
```
Now add the BlocProvider widget before MaterialApp


``` dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //add yours BLoCs controlles
      blocs: [
        Bloc((i) => ValueBloc()),
      ],
      //your main widget 
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
...
```

You can search for a BLoC class anywhere in your application using:

``` dart
    //recovering your Bloc
  final ValueBloc bloc = BlocProvider.getBloc<ValueBloc>();
```

Or consume directly on the Target widget using Consumer<T>().

``` dart
    //Cosume your BLoC
  Consumer<ValueBloc>(
    builder: (BuildContext context, ValueBloc valueBloc) {
      return _textValue(valueBloc.value);
    },
  ),
  Container(
    height: 25,
  ),
  Consumer<ValueBloc>(
    builder: (BuildContext context, ValueBloc valueBloc) {
      return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.white,
      min: 0.0,
      max: 1.0,
      onChanged: valueBloc.onChangeValue,
      value: valueBloc.value);
    },
  ),
```

In this way, every time the ValueBloc onChangeValue method, the widgets inside the consumer will have new data.
Access the complete project [`clicking here`](https://github.com/jacobaraujo7/slider_bloc).


# Using Streams and Reactive Programming (Rx)

You can also use the provider to get BlocClasses that work with streams for more complex processing using reactive programming.



``` dart
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocController extends BlocBase {

BlocController();

//Stream that receives a number and changes the count;
var _counterController = BehaviorSubject<int>.seeded(0);
//output
Stream<int> get outCounter => _counterController.stream;
//input
Sink<int> get inCounter => _counterController.sink;

increment(){
    inCounter.add(_counterController.value+1);
}

//dispose will be called automatically by closing its streams
@override
void dispose() {
  _counterController.close();
  super.dispose();
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

# Tag Module

Now you can create other BlocProvider's independently. To do this use the "tagText" property giving a name for your new BlocProvider segment. You need use Tag Module to work with multiples provides through the aplication. If you need instatiate another BlocProvider, you will need tag itself, otherwise you will get an error.

``` dart

...
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //tag module
      tagText: "newModule",
  ...

```
From here you can call your blocks and dependency registered in your new module using:

``` dart
    BlocProvider.tag("newModule").getBloc<BlocController>();
```

When you exit your tree of widget elements your BlocProvider will call the dispose () of that module only.X

## ModuleWidget

ModuleWidget uses the Tag Module implicitly, automating module creation for dependency injection. Basically creates a BlocProvider and the module tag is the name of the class itself.
With this we can use the ModuleWidget instead of an instance of a StatelessWidget with the Widget of the BlocProvider using tag.

``` dart 
class HomeModule extends ModuleWidget {

  //Inject the blocs
  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc((i) => IncrementController())),
        Bloc((i) => DecrementController())
      ];

  //Inject the dependencies
  @override
  List<Dependency> get dependencies => [
        Dependency((i) => GeneralApi(i.params['name'])),
      ];

  //main widget
  @override
  Widget get view => HomeWidget();

  //shortcut to pick up dependency injections from this module
  static Inject get to => Inject<HomeModule>.of();

}
```

When using the Module Widget you do not have to worry about using tags, to access the module just use:

``` dart 
  //use
  HomeModule.to.bloc<HomeBloc>();
  //instead
  BlocProvider.tag("HomeModule").bloc<HomeBloc>();
  
  //using the Consumer pattern with widget ConsumerModule
  ConsumerModule<HomeBloc, HomeModule>(
    builder: (context, value){
      ...
    }
  ); 

```

# Dispose

The data is automatically discarded when the application finishes, however if you want to do this manually or restart some injected singleton, use:

``` dart
//dispose BLoC
BlocProvider.disposeBloc<BlocController>();

//dispose dependency
BlocProvider.disposeDependency<GeneralApi>();


//dispose BLoC in Module
BlocProvider.tag("HomeModule").disposeBloc<BlocController>();

//dispose BLoC in ModuleWidget
HomeModule.to.disposeBloc<BlocController>();


```


[Optional] Add the dispose to your Bloc so that it can be called automatically or manually.

``` dart

class YourBloc extends BlocBase {

  @override
  void dispose(){
    super.dispose
    //dispose Objects
  }
}

```


[Optional] Extend you Service or Repositore with Disposable for automatic dipose.

``` dart

class GeneralApi extends Disposable {

  @override
  void dispose(){
    //dispose Objects
  }
}

```

THAT´S ALL

## For more information

Access the Flutterando Blog [Clicking here](https://flutterando.com.br).
