import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

abstract class ModuleWidget extends StatelessWidget {

  List<Bloc> get blocs;
  List<Dependency> get dependencies;
  Widget get view;

  Inject get inject => BlocProvider.tag(this.runtimeType.toString());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      tagText: this.runtimeType.toString(),
      blocs: blocs,
      dependencies: dependencies,
      child: view,);
  }

}