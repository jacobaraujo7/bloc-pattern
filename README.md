# Bloc Pattern

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6UTC2V72FL644&source=url)

Package that helps you implementing BloC Pattern by Dependency Injection in your project.


## Package

[bloc_pattern](https://pub.dev/packages/bloc_pattern)


## What is BloC?

BLoC stands for Business Logic Components. The gist of BLoC is that everything in the app should be represented as stream of events: widgets submit events; other widgets will respond. BLoC sits in the middle, managing the conversation. It will be created separately from the view, isolating the logic of the code.

## Why to use bloc_pattern?

It's perfect to organize, and follow the best practices in your code, taking vantage of **Dependency Injection**. And it's the best package to use with [`slidy`](https://github.com/Flutterando/slidy) (created to structure your Flutter project).


# How to implement?

### First step.

Add [`bloc_pattern`](https://pub.dartlang.org/packages/bloc_pattern) in your pubspec.yaml. 

```yaml
dependencies:

  bloc_pattern: ^2.3.2

```

Or you can use [`slidy`](https://github.com/Flutterando/slidy) to add in your dependencies: 

```
slidy install bloc_pattern

```

## Starting to code

## 1. 

Create the BloC class of your module, and extends from **BlocBase**.

``` dart
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends BlocBase{

  Observable<int> counter; // observable (Stream)

  CounterBloc() {
    counter = Observable.merge([ //merges the both streams 
      _increment,
      _decrement,
    ]).startWith(0) //starts with the value 0(the initial data)
    .scan((acc, curr, i) => acc + curr, 0 /* inital value: 0 */) // scans the old(acc) and the current(curr) value, and sum them
    .asBroadcastStream(); //turns the stream into a Broadcast straem(it can be listened to more than once)
  }

  final _increment = new BehaviorSubject<int>(); //the BehaviorSubject gets the last value
  final _decrement = new BehaviorSubject<int>();

  void increment() => _increment.add(1); //method to increment
  void decrement() => _decrement.add(-1);//method to decrement


@override
  void dispose() {// will be called automatically 
    _increment.close();
    _decrement.close();
  }

}
```

## 2.

Now wrap your MaterialApp into a **BlocProvider**. Obs.: **BlocProvider** is the widget where you can Inject all the BloCs, and then recover them anywhere in your application.

``` dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc((i) => CounterBloc()),
      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
...
```

## Recovering the BloC class.

``` dart
    //recovering your BloC
  final bloc = BlocProvider.getBloc<CounterBloc>();
```

## Using StreamBuilder 

The **StreamBuilder** widgets lets you change the UI reactively without needing to call setState()(that rebuilds the stateful widget);

``` dart
StreamBuilder(
                stream: bloc.outCounter,  //here you call the flux of data(stream)
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
```

## Consuming the BloC directly from the Widget

You can consume your BloC directly from the target Widget using the **Consumer()** class. 
 Everytime the CounterBloc adds a new value, the widgets within the **Consumer** will have new data.
 You can see the project source code [`here`](https://github.com/LilySny/counter-using-bloc_pattern).

### BloC using Consume(): 

``` dart
class CounterBloc {
    ...
int counter = 0;
onChanged(){
  counter++;
  notifyListeners(); //notifies when occurs a change
}

}

```

``` dart
 Consumer<CounterBloc>(
            builder: (BuildContext context, CounterBloc bloc) {
              return Text(bloc.counter.toString()); //calling the counter value
          ),
          SizedBox(
            height: 25.0,
          ),
          Consumer<CounterBloc>(
            builder: (BuildContext context, CounterBloc bloc) {
              return 
            RaisedButton(
              onPressed: () {
                bloc.onChanged(); //calling onChanged() that will increment the value
              },
              child: Icon(Icons.add),
            );
            },
          ),
```

# Dependency Injection

You can also inject other dependencies aside BloC:

``` dart
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
        Dependency((i) => GeneralApi(i.params['name'])), //repository
      ],
    );
  }
```
You can define if the dependency will be a **Singleton** or not:

``` dart
<<<<<<< HEAD
Bloc((i) => CounterBloc(), singleton: true)
=======

Bloc((i) => CounterBloc(), singleton: true)

>>>>>>> readme
```

To inject the dependency in your class use:

``` dart

@override
  Widget build(BuildContext context) {
   
    //recovering your API dependency
  final GeneralApi api = BlocProvider.getDependency<GeneralApi>(); //repository
  
  //Passing Data through parameters
  final UserModel user = BlocProvider.getDependency<UserModel>({
    "id": 1,
    "name": "João"
  });
  ....
}

```

# Tags

You can create new **BlocProviders** independently. 

* Use the property "tagText" giving a name for your new **BlocProvider**.  
* When you have more than one BlocProvider, you will need to use its tag to indentificate, otherwise it should return an error.

``` dart

...
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //tag module
      tagText: "newModule",
  ...

```

Calling the dependencies and BloCs from other classes:

``` dart

    BlocProvider.tag("newModule").getBloc<BlocController>();
    ...

```

## ModuleWidget

The **ModuleWidget** uses Tag Module in its structure: 

* Implicity creates a **tag** for the module class.
* Gets automatically the tag when you call the module BloC.

> You can use [`Slidy`](https://github.com/Flutterando/slidy) to create the module

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
So instead of using BlocProvider and tags, you can just use **ModuleWidget**, it will also organize and modularize your project.

``` dart 
  //use
  HomeModule.to.bloc<HomeBloc>();
  //instead of
  BlocProvider.tag("HomeModule").bloc<HomeBloc>();

```

# Dispose

**It's important to always call the dispose(), to make sure that the objects won't continue processing when you don't have any data.**

The BlocBase already comes with Disposable, you just need to override it and will be called automatically in your ModuleWidget

``` dart
class YourBloc extends BlocBase {

  @override
  void dispose(){
    super.dispose
    //dispose Objects
  }
}

```

To do this manually or restart some injected singleton, use:

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

**[Optional]** Extends Disposable in your *service* or *repository* for automatic dispose.

``` dart

class Repository extends Disposable {

  @override
  void dispose(){
    //dispose Objects
  }
}

```


### For more information

Access [Flutterando Blog](https://flutterando.com.br).
