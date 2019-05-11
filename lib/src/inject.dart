import 'package:bloc_pattern/bloc_pattern.dart';

class Inject {
  Map<String, dynamic> params = {};
  final String tag;

  Inject({this.params, this.tag = "global"});

  ///get injected dependency
  get<T>([Map<String, dynamic> params]) {
    params ??= {};
    return BlocProvider.getDependency<T>(params, tag);
  }

  ///get injected dependency
  getDependency<T>([Map<String, dynamic> params]) {
    return get<T>(params);
  }

  disposeBloc<T>([String tag]) {
    return BlocProvider.disposeBloc(tag);
  }

  disposeDependency<T>([String tag]) {
    return BlocProvider.disposeDependency(tag);
  }

  ///get injected bloc;
  bloc<T extends BlocBase>([Map<String, dynamic> params]) {
    params ??= {};
    return BlocProvider.getBloc<T>(params, tag);
  }

  ///get injected bloc;
  getBloc<T extends BlocBase>([Map<String, dynamic> params]) {
    params ??= {};
    return bloc<T>(params);
  }
}
