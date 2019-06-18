class ModuloModel {
  String model(String name) => '''
  class ${name}Module extends Module {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => Container();

  static Inject get to => Inject<${name}Module>.of();

}
  ''';
}