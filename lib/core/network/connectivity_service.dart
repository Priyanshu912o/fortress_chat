import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class ConnectivityService {
  final Connectivity _connectivity;
  final BehaviorSubject<bool> _isOnlineController = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get isOnlineStream => _isOnlineController.stream.distinct();
  bool get isOnline => _isOnlineController.value;

  ConnectivityService() : _connectivity = Connectivity() {
    _init();
  }

  void _init() {
    _connectivity.checkConnectivity().then(_updateStatus);
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => r != ConnectivityResult.none);
    _isOnlineController.add(hasConnection);
  }

  void dispose() {
    _isOnlineController.close();
  }
}
