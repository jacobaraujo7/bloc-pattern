import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_web/material.dart';

class Consumer<T extends BlocBase> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;

  const Consumer({Key key, @required this.builder}) : super(key: key);

  @override
  _ConsumerState<T> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends BlocBase> extends State<Consumer<T>> {
  T value;

  void listener() {
    setState(() {
      value = BlocProvider.getBloc<T>();
    });
  }

  @override
  void initState() {
    value = BlocProvider.getBloc<T>();
    value.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    value.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
