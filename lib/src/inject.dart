import 'package:bloc_pattern/bloc_pattern.dart';

class Inject<T> {
  Map<String, dynamic> params = {};
  final String tag;

  Inject({this.params, this.tag = "global"});

  factory Inject.of() => Inject(tag: T.toString());

  ///get injected dependency
  T get<T>([Map<String, dynamic> params]) {
    params ??= {};
    return BlocProvider.getDependency<T>(params, tag);
  }

  ///get injected dependency
  T getDependency<T>([Map<String, dynamic> params]) {
    return get<T>(params);
  }

  disposeBloc<T extends BlocBase>([String tag]) {
    return BlocProvider.disposeBloc<T>(tag);
  }

  disposeDependency<T>([String tag]) {
    return BlocProvider.disposeDependency<T>(tag);
  }

  ///get injected bloc;
  T bloc<T extends BlocBase>([Map<String, dynamic> params]) {
    params ??= {};
    return BlocProvider.getBloc<T>(params, tag);
  }

  ///get injected bloc;
  T getBloc<T extends BlocBase>([Map<String, dynamic> params]) {
    params ??= {};
    return bloc<T>(params);
  }
}
