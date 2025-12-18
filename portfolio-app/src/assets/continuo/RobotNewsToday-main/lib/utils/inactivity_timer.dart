import 'dart:async';
import 'package:flutter/material.dart';

/// InactivityTimer is a singleton that manages the global inactivity logic.
/// It is invisible to the user and only triggers a callback after [timeout] of inactivity.
class InactivityTimer with WidgetsBindingObserver {
  static final InactivityTimer _instance = InactivityTimer._internal();
  factory InactivityTimer() => _instance;
  InactivityTimer._internal();

  Timer? _timer;
  Duration timeout = const Duration(seconds: 60);
  VoidCallback? onTimeout;
  bool _paused = false;

  void start(VoidCallback onTimeout, {Duration? customTimeout}) {
    this.onTimeout = onTimeout;
    timeout = customTimeout ?? const Duration(seconds: 60);
    _reset();
    WidgetsBinding.instance.addObserver(this);
  }

  void _reset() {
    _timer?.cancel();
    if (!_paused) {
      _timer = Timer(timeout, () {
        if (!_paused && onTimeout != null) onTimeout!();
      });
    }
  }

  void userActivity() {
    _reset();
  }

  void pause() {
    _paused = true;
    _timer?.cancel();
  }

  void resume() {
    _paused = false;
    _reset();
  }

  void stop() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      pause();
    } else if (state == AppLifecycleState.resumed) {
      resume();
    }
  }
}
