import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Consumer<T extends BlocBase> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final String tag;
  final bool Function(T oldValue, T newValue)? distinct;

  Consumer({Key? key, required this.builder, this.tag = "global", this.distinct}) : super(key: key);

  @override
  _ConsumerState<T> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends BlocBase> extends State<Consumer<T>> {
  late T value;

  String tag = "global";

  void listener() {
    T newValue = BlocProvider.tag(widget.tag).getBloc<T>();
    if (widget.distinct == null || widget.distinct?.call(value, newValue) != true) {
      setState(() {
        value = newValue;
      });
    }
  }

  @override
  void initState() {
    value = BlocProvider.tag(widget.tag).getBloc<T>();
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
