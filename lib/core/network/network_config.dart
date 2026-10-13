class NetworkConfig {
  static const String _defaultServer = '51.20.40.211:3000';
  static const String _envHost = String.fromEnvironment('BACKEND_HOST', defaultValue: _defaultServer);
  static String? _resolvedHost;

  /// Resolves the optimal backend host:
  /// Uses AWS EC2 public server (51.20.40.211:3000) for all platforms.
  static Future<String> resolveHost() async {
    if (_resolvedHost != null) return _resolvedHost!;

    if (_envHost.isNotEmpty) {
      _resolvedHost = _envHost.replaceFirst('http://', '').replaceFirst('https://', '');
      return _resolvedHost!;
    }

    _resolvedHost = _defaultServer;
    return _resolvedHost!;
  }

  static String get baseUrl {
    if (_resolvedHost != null) {
      return 'http://$_resolvedHost';
    }
    if (_envHost.isNotEmpty) {
      return _envHost.startsWith('http') ? _envHost : 'http://$_envHost';
    }
    return 'http://$_defaultServer';
  }

  static String get wsUrl {
    if (_resolvedHost != null) {
      return 'ws://$_resolvedHost/ws';
    }
    if (_envHost.isNotEmpty) {
      final clean = _envHost.replaceFirst('http://', '').replaceFirst('https://', '');
      return 'ws://$clean/ws';
    }
    return 'ws://$_defaultServer/ws';
  }
}
