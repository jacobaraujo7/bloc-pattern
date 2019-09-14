import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_pattern/src/bloc.dart';
import 'package:bloc_pattern/src/bloc_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dependency.dart';

final Map<String, Core> _injectMap = {};
final Map<String, Core> _injectMapHelper = {};

class BlocProvider extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    this.blocs,
    this.dependencies,
    //  this.views,
    this.tagText = "global",
  }) : super(key: key) {
    if (!_injectMap.containsKey(tagText)) {
      _injectMap[tagText] = Core(
        blocs: this.blocs,
        dependencies: this.dependencies,
        tag: this.tagText,
        //  views: this.views,
      );
    } else {
      _injectMapHelper[tagText] = Core(
        blocs: this.blocs,
        dependencies: this.dependencies,
        tag: this.tagText,
        //  views: this.views,
      );
    }
  }

  final List<Bloc> blocs;
  final List<Dependency> dependencies;
  final String tagText;
  // final List<Widget> views;
  final Widget child;

  @override
  _BlocProviderListState createState() => _BlocProviderListState();

  ///Use to inject a BLoC. If BLoC is not instantiated, it starts a new singleton instance.
  static T getBloc<T extends BlocBase>(
      [Map<String, dynamic> params, String tag = "global"]) {
    try {
      Core core = _injectMapHelper.containsKey(tag)
          ? _injectMapHelper[tag]
          : _injectMap[tag];

      return core.bloc<T>(params);
    } on BlocProviderException {
      rethrow;
    } catch (e) {
      if (e.message == "No element") {
        throw BlocProviderException(
            "${T.toString()} is not part of '$tag'. Check Injected BLoC's");
      } else {
        throw e;
      }
    }
  }

  ///tag inject of BLocs, Dependency and Views.
  static Inject tag(String tagText) => Inject(tag: tagText);

  ///Use to inject a Dependency. If the Dependency is not instantiated, it starts a new instance. If it is marked as a singleton, the instance persists until the end of the application, or until the [disposeDependency];
  static T getDependency<T>(
      [Map<String, dynamic> params, String tag = "global"]) {
    try {
      Core core = _injectMap[tag];
      return core.dependency<T>(params);
    } on BlocProviderException {
      rethrow;
    } catch (e) {
      if (e.message == "No element") {
        throw BlocProviderException(
            "${T.toString()} is not part of '$tag'. Check Injected Dependencies");
      } else {
        throw e;
      }
    }
  }

  ///Discards BLoC from application memory
  static void disposeBloc<T extends BlocBase>([String tagText = "global"]) {
    if (_injectMap.containsKey(tagText)) {
      Core core = _injectMap[tagText];
      core?.removeBloc<T>();
    }
  }

  ///Discards Dependency from application memory
  static void disposeDependency<T>([String tagText = "global"]) {
    if (_injectMap.containsKey(tagText)) {
      Core core = _injectMap[tagText];
      core?.removeDependency<T>();
    }
  }
}

class _BlocProviderListState extends State<BlocProvider> {
  @override
  void initState() {
    super.initState();
    print("BLOCPROVIDER START (${widget.tagText})");
  }

  @override
  void dispose() {
    Core core = _injectMap[widget.tagText];
    core?.dispose();
    if (_injectMapHelper.containsKey(widget.tagText)) {
      _injectMap[widget.tagText] = _injectMapHelper[widget.tagText];
      _injectMapHelper.remove(widget.tagText);
      print(" --- DISPOSE BLOC ADDED ---- (${widget.tagText})");
    } else {
      _injectMap.remove(widget.tagText);
      print(" --- DISPOSE BLOC PROVIDER---- (${widget.tagText})");
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
