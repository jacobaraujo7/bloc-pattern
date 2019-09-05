class BlocProviderException implements Exception {
  final String message;

  const BlocProviderException([this.message]);

  @override
  String toString() {
    if (message == null) return "BlocProviderException";
    return "BlocProvider: $message";
  }
}
