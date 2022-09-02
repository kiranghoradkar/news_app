import 'package:connectivity_plus/connectivity_plus.dart';

// Class to check internet connection
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  const NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async =>
      await connectivity.checkConnectivity() != ConnectivityResult.none;
}
