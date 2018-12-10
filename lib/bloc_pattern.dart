library bloc_pattern;

import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    // final type = _typeOf<BlocProvider<T>>();
    // BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    final type = _typeOf<_HelperBlocProvider<T>>();
    _HelperBlocProvider<T> provider = context.inheritFromWidgetOfExactType(type);
    provider.bloc.context = context;
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return _HelperBlocProvider<T>(child: widget.child, bloc: widget.bloc,);
  }
}

class _HelperBlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  _HelperBlocProvider({this.bloc, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}