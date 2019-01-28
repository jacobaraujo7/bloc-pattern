library bloc_pattern;

import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_HelperBlocProvider<T>>();
    _HelperBlocProvider<T> provider =
        context.inheritFromWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T extends BlocBase>
    extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  T bloc; 

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc;
  }

  @override
  Widget build(BuildContext context) {
    return _HelperBlocProvider<T>(
      child: widget.child,
      bloc: bloc,
    );
  }
}

class _HelperBlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  _HelperBlocProvider({this.bloc, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}


class Bloc<T extends BlocBase> {
  final T bloc;

  Bloc(this.bloc);
}

class BlocProviderList extends StatefulWidget {
  BlocProviderList({
    Key key,
    @required this.child,
    this.listBloc,
  }) : super(key: key);

  final List<Bloc> listBloc;
  final Widget child;

  @override
  _BlocProviderListState createState() => _BlocProviderListState();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_HelperBlocListProvider>();

    _HelperBlocListProvider provider =
    context.inheritFromWidgetOfExactType(type);

    BlocBase bloc = provider.listBloc.where((bloc) => bloc.bloc is T).toList()[0]?.bloc;

    return bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderListState extends State<BlocProviderList> {
  @override
  void dispose() {

    for (int i=0; i<bloc.length;i++){
      bloc[i].bloc.dispose();
    }

//    bloc.forEach((bloc){
//      bloc.bloc.dispose();
//    });

    super.dispose();
  }

  List<Bloc> bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.listBloc;
  }

  @override
  Widget build(BuildContext context) {
    return _HelperBlocListProvider(
      child: widget.child,
      listBloc: bloc,
    );
  }
}

class _HelperBlocListProvider extends InheritedWidget {
  final List<Bloc> listBloc;

  _HelperBlocListProvider({this.listBloc, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}

