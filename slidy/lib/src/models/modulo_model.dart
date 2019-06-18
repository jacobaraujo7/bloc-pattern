import 'package:slidy/src/utils/utils.dart';

class ModuloModel {
  static String model(String name) {
    String all = formatName(name);

    String values = '''
  class ${all}Module extends Module {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => Container();

  static Inject get to => Inject<${all}Module>.of();

}
  ''';
    return values;
  }
}
