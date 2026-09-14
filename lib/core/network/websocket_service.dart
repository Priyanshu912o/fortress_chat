import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'connectivity_service.dart';

import 'network_config.dart';

@lazySingleton
class WebSocketService {
  final FirebaseAuth _auth;
  final ConnectivityService _connectivity;

  WebSocketChannel? _channel;
  StreamSubscription? _channelSubscription;
  StreamSubscription? _connectivitySubscription;
  Timer? _reconnectTimer;
  Timer? _pingTimer;

  bool _isDisposed = false;
  bool _isConnected = false;
  int _reconnectAttempts = 0;

  final PublishSubject<Map<String, dynamic>> _eventsController =
      PublishSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get events => _eventsController.stream;
  bool get isConnected => _isConnected;

  static String get defaultWsUrl => NetworkConfig.wsUrl;

  WebSocketService(this._auth, this._connectivity) {
    _init();
  }

  void _init() {
    _connectivitySubscription = _connectivity.isOnlineStream.listen((online) {
      if (online && !_isConnected) {
        connect();
      } else if (!online) {
        _disconnectChannel();
      }
    });

    _auth.authStateChanges().listen((user) {
      if (user != null) {
        connect();
      } else {
        disconnect();
      }
    });
  }

  Future<void> connect() async {
    if (_isDisposed || _isConnected) return;
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final token = await user.getIdToken();
      if (token == null) return;

      _channel = WebSocketChannel.connect(Uri.parse(defaultWsUrl));
      await _channel!.ready;
      _isConnected = true;
      _reconnectAttempts = 0;

      // Authenticate immediately
      _sendRaw({
        'type': 'authenticate',
        'token': token,
      });

      _channelSubscription = _channel!.stream.listen(
        (data) {
          try {
            final Map<String, dynamic> decoded = jsonDecode(data as String);
            _eventsController.add(decoded);
          } catch (e) {
            // Ignore parse errors
          }
        },
        onDone: () {
          _handleDisconnect();
        },
        onError: (error) {
          _handleDisconnect();
        },
      );

      _startPingTimer();
    } catch (e) {
      _handleDisconnect();
    }
  }

  void _sendRaw(Map<String, dynamic> data) {
    if (_isConnected && _channel != null) {
      try {
        _channel!.sink.add(jsonEncode(data));
      } catch (e) {
        _handleDisconnect();
      }
    }
  }

  void sendTyping(String chatRoomId, bool isTyping) {
    _sendRaw({
      'type': isTyping ? 'typing_start' : 'typing_stop',
      'chatRoomId': chatRoomId,
    });
  }

  void sendMessage(String chatRoomId, String body, String clientMessageId) {
    _sendRaw({
      'type': 'send_message',
      'chatRoomId': chatRoomId,
      'body': body,
      'clientMessageId': clientMessageId,
    });
  }

  void markRead(String chatRoomId) {
    _sendRaw({
      'type': 'mark_read',
      'chatRoomId': chatRoomId,
    });
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected) {
        _sendRaw({'type': 'ping'});
      }
    });
  }

  void _handleDisconnect() {
    _isConnected = false;
    _disconnectChannel();

    if (!_isDisposed && _connectivity.isOnline && _auth.currentUser != null) {
      _reconnectAttempts++;
      final delaySeconds = min(pow(2, _reconnectAttempts).toInt(), 30);
      _reconnectTimer?.cancel();
      _reconnectTimer = Timer(Duration(seconds: delaySeconds), () {
        connect();
      });
    }
  }

  void _disconnectChannel() {
    _pingTimer?.cancel();
    _channelSubscription?.cancel();
    _channelSubscription = null;
    try {
      _channel?.sink.close();
    } catch (_) {}
    _channel = null;
    _isConnected = false;
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _disconnectChannel();
  }

  void dispose() {
    _isDisposed = true;
    disconnect();
    _connectivitySubscription?.cancel();
    _eventsController.close();
  }
}
