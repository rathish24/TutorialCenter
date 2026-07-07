import 'package:connectivity_plus/connectivity_plus.dart';

/// Contract representing internet connection capabilities check.
abstract class ConnectivityService {
  Future<bool> isConnected();
}

/// Concrete implementation of [ConnectivityService] using the `connectivity_plus` package.
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityServiceImpl(this._connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    // Return true if connected to mobile data, wifi, or ethernet
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }
}
