class NoElementFoundException implements Exception {
  final String typeName;
  final String moduleName;

  const NoElementFoundException([this.typeName, this.moduleName]);

  @override
  String toString() {
    if (typeName == null ) return "NoElementFoundException";
    return "$typeName is not part of $moduleName. Check Injected BLoC's and Dependencies";
  }
}