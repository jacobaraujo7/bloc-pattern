import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_pattern/src/bloc.dart';
import 'package:bloc_pattern/src/bloc_base.dart';
import 'package:bloc_pattern/src/injectable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dependency.dart';

final Map<String, Core> _injectMap = {};

class BlocProvider extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    List<Bloc> blocs,
    List<Dependency> dependencies,
    //  this.views,
    this.tagText = "global",
  })  : injectables = List<Injectable>(),
        super(key: key) {
    if (!_injectMap.containsKey(tagText)) {
      injectables.addAll(blocs);
      injectables.addAll(dependencies);

      _injectMap[tagText] = Core(injectables: injectables, tag: tagText
          //  views: this.views,
          );
    }
  }

  final List<Injectable> injectables;
  final String tagText;
  // final List<Widget> views;
  final Widget child;

  @override
  _BlocProviderListState createState() => _BlocProviderListState();

  ///Use to inject a BLoC. If BLoC is not instantiated, it starts a new singleton instance.

  static T getBloc<T extends BlocBase>(
      [Map<String, dynamic> params, String tag = "global"]) {
    return _getInjectable<T>(params, tag);
  }

  ///tag inject of BLocs, Dependency and Views.
  static Inject tag(String tagText) => Inject(tag: tagText);

  ///Use to inject a Dependency. If the Dependency is not instantiated, it starts a new instance. If it is marked as a singleton, the instance persists until the end of the application, or until the [disposeDependency];
  static T getDependency<T>(
      [Map<String, dynamic> params, String tag = "global"]) {
    return _getInjectable<T>(params, tag);
  }

  static T _getInjectable<T>(
      [Map<String, dynamic> params, String tag = "global"]) {
    try {
      Core core = _injectMap[tag];
      return core.getInjectable<T>(params);
    } on BlocProviderException {
      rethrow;
    } catch (e) {
      if (e.message == "No element") {
        throw BlocProviderException(
            "${T.toString()} is not part of '$tag'. Check Injected BLoC's and Dependencies");
      } else {
        throw e;
      }
    }
  }

  ///Discards the Bloc of type [T] from application memory
  static void disposeBloc<T extends BlocBase>([String tagText = "global"]) {
    _disposeInjectable<T>(tagText);
  }

  ///Discards the Dependency of type [T] from application memory
  static void disposeDependency<T>([String tagText = "global"]) {
    _disposeInjectable<T>(tagText);
  }

  ///Discards the Injectable from application memory
  static void _disposeInjectable<T>([String tagText = "global"]) {
    if (_injectMap.containsKey(tagText)) {
      Core core = _injectMap[tagText];
      core?.remove<T>();
    }
  }
}

class _BlocProviderListState extends State<BlocProvider> {
  @override
  void initState() {
    super.initState();
    print("--- BLOC PROVIDER START --- (${widget.tagText})");
  }

  @override
  void dispose() {
    Core core = _injectMap[widget.tagText];
    core?.dispose();
    _injectMap.remove(widget.tagText);
    print(" --- DISPOSE BLOC PROVIDER --- (${widget.tagText})");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
