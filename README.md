# Bloc Pattern

Apenas um Provider para implementar o Bloc no seu Código Flutter

## Iniciando


Adicione o `bloc_pattern` no seu pubspec.yaml.

Crie um Controller Bloc implementando o `BlocBase` e adicione suas streams:

``` dart
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocController implements BlocBase {

//fluxo que recebe um numero e altera a contagem;
var _counterController = BehaviorSubject<int>(seedValue: 0);
//saida
Stream<int> get outCounter => _counterController.stream;
//entrada
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

Adicione o Provider no Widget principal da sua arvore de widgets passando como parametro o seu BlocController

``` dart

home: BlocProvider<BlocController>(
        child: MyHomePage(title: 'Flutter Demo Home Page'),
        bloc: BlocController(),
      ),


}

```


Agora você já pode recuperar seu Bloc em qualquer lugar de sua árvore de widget com ajuda do `BlocProvider`

``` dart

@override
  Widget build(BuildContext context) {
    //recuperando seu Bloc
  final BlocController bloc = BlocProvider.of<BlocController>(context);

  ....


}

```


Agora basta que use o `StreamBuilder` para receber os seus fluxos e alterar a UI sem precisar do SetState

``` dart

StreamBuilder(
    stream: bloc.outCounter,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Text(
        'Você tocou ${snapshot.data}',
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

