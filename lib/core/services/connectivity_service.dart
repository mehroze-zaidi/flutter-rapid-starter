import 'package:connectivity_plus/connectivity_plus.dart';

/// Singleton that monitors network connectivity.
///
/// Call [initialize] once at app startup to seed the initial state.
/// Subscribe to [onConnectivityChanged] to react to changes.
///
/// Usage:
///   await ConnectivityService.instance.initialize();
///   ConnectivityService.instance.onConnectivityChanged.listen((isConnected) { ... });
class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final _connectivity = Connectivity();

  bool _isConnected = true;

  /// The last known connectivity state.
  bool get isConnected => _isConnected;

  /// Stream that emits [true] when connected and [false] when offline.
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  /// Seeds [isConnected] with the current network state.
  /// Call once before [runApp].
  Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    _isConnected = _hasConnection(result);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    _isConnected = results.any((r) => r != ConnectivityResult.none);
    return _isConnected;
  }
}
