import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ConsumerModule<T extends BlocBase , R extends ModuleWidget> extends Consumer<T> {
  
  final Widget Function(BuildContext context, T value) builder;

  ConsumerModule({Key key, @required this.builder}) : super(key: key, builder: builder, tag: R.toString());
}