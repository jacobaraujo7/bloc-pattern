import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Consumer<T extends BlocBase> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final String tag;
  final Type module;

  Consumer({Key key, @required this.builder, this.tag = "global", this.module}) : super(key: key);

  @override
  _ConsumerState<T> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends BlocBase> extends State<Consumer<T>> {
  T value;

  String tag = "global";

  void listener() {
    setState(() {
      value = BlocProvider.tag(tag).getBloc<T>();
    });
  }

  @override
  void initState() {
    tag = widget.module?.toString() ?? widget.tag;
    value = BlocProvider.tag(tag).getBloc<T>();
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
