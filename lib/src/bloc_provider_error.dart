class BlocProviderException implements Exception {
  String cause;
  BlocProviderException(this.cause);

  @override
  String toString() {
    // TODO: implement toString
    return "BlocProvider: $cause";
  }

}