import 'dart:async';
import 'package:flutter/material.dart';

class AutoLockService {
  Timer? _idleTimer;
  Duration _lockDuration;
  VoidCallback? _onLock;
  bool _isLocked = false;
  DateTime? _lastActivity;

  AutoLockService({
    Duration? lockDuration,
    VoidCallback? onLock,
  })  : _onLock = onLock,
        _lockDuration = lockDuration ?? const Duration(minutes: 1);

  Duration get lockDuration => _lockDuration;
  bool get isLocked => _isLocked;

  void setLockDuration(Duration duration) {
    _lockDuration = duration;
    _resetTimer();
  }

  void setOnLock(VoidCallback callback) {
    _onLock = callback;
  }

  void start() {
    _lastActivity = DateTime.now();
    _resetTimer();
  }

  void stop() {
    _idleTimer?.cancel();
    _idleTimer = null;
  }

  void resetTimer() {
    _lastActivity = DateTime.now();
    _resetTimer();
  }

  void _resetTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(_lockDuration, _triggerLock);
  }

  void _triggerLock() {
    if (!_isLocked) {
      _isLocked = true;
      _onLock?.call();
    }
  }

  void unlock() {
    _isLocked = false;
    _lastActivity = DateTime.now();
    _resetTimer();
  }

  Duration get timeUntilLock {
    if (_lastActivity == null) return _lockDuration;
    final elapsed = DateTime.now().difference(_lastActivity!);
    final remaining = _lockDuration - elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  void dispose() {
    stop();
  }
}
