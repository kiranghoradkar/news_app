// Failure classes

// This class is for server failure
class ServerFailure implements Exception {
  final String message;

  ServerFailure({required this.message});

  @override
  String toString() {
    return message;
  }
}

// This class is for no internet
class NoInternet implements Exception {
  final String message;

  NoInternet({required this.message});

  @override
  String toString() {
    return message;
  }
}
