import 'dart:io';

class NetworkConfig {
  static const String _envHost = String.fromEnvironment('BACKEND_HOST');
  static String? _resolvedHost;

  /// Resolves the optimal backend host:
  /// 1. BACKEND_HOST compile-time environment variable (if provided).
  /// 2. For physical Android devices via USB (`adb reverse`), 127.0.0.1:3000 succeeds immediately.
  /// 3. For Android Emulator, falls back to 10.0.2.2:3000.
  /// 4. For iOS / macOS / Desktop, uses 127.0.0.1:3000.
  static Future<String> resolveHost() async {
    if (_resolvedHost != null) return _resolvedHost!;

    if (_envHost.isNotEmpty) {
      _resolvedHost = _envHost.replaceFirst('http://', '').replaceFirst('https://', '');
      return _resolvedHost!;
    }

    if (Platform.isAndroid) {
      try {
        final socket = await Socket.connect(
          '127.0.0.1',
          3000,
          timeout: const Duration(milliseconds: 400),
        );
        socket.destroy();
        _resolvedHost = '127.0.0.1:3000';
        return _resolvedHost!;
      } catch (_) {
        _resolvedHost = '10.0.2.2:3000';
        return _resolvedHost!;
      }
    }

    _resolvedHost = '127.0.0.1:3000';
    return _resolvedHost!;
  }

  static String get baseUrl {
    if (_resolvedHost != null) {
      return 'http://$_resolvedHost';
    }
    if (_envHost.isNotEmpty) {
      return _envHost.startsWith('http') ? _envHost : 'http://$_envHost';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://127.0.0.1:3000';
  }

  static String get wsUrl {
    if (_resolvedHost != null) {
      return 'ws://$_resolvedHost/ws';
    }
    if (_envHost.isNotEmpty) {
      final clean = _envHost.replaceFirst('http://', '').replaceFirst('https://', '');
      return 'ws://$clean/ws';
    }
    if (Platform.isAndroid) {
      return 'ws://10.0.2.2:3000/ws';
    }
    return 'ws://127.0.0.1:3000/ws';
  }
}
