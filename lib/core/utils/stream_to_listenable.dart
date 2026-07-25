import 'dart:async';

import 'package:flutter/material.dart';

class StreamToListenable extends ChangeNotifier{
  late final StreamSubscription<dynamic> _subscription;

  StreamToListenable(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}