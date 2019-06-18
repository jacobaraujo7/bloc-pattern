class ModuloModel {
  static String model(String name) {
    String first = name[0];

    String all = name.replaceFirst(first, first.toUpperCase());

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
