import 'package:exemple/blocmain_controller.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<BlocController>(child: MyHomePage(title: 'Flutter Demo Home Page'), bloc: BlocController(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {

    print("Construiu Widget");

    final BlocController bloc = BlocProvider.of<BlocController>(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: bloc.increment,)
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),

            StreamBuilder(
              stream: bloc.outCounter,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
              'Você tocou ${snapshot.data}',
              style: Theme.of(context).textTheme.display1,
            );
            },),

          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: bloc.increment,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
