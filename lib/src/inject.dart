import 'package:bloc_pattern/bloc_pattern.dart';

class Inject {
  final Map<String , dynamic> params;

  Inject(this.params);

  ///get injected dependency
  get<T>([Map<String , dynamic> params]){
    return BlocProvider.getDependency<T>(params);
  }

  ///get injected bloc;
  bloc<T extends BlocBase>([Map<String , dynamic> params]){
    return BlocProvider.getBloc<T>(params);
  }

}