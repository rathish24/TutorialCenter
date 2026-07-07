import 'package:flutter/foundation.dart';

/// Logging utility for tracking Firebase database and authentication events.
class FirebaseLogger {
  final bool isDebug;
  final void Function(String message)? externalLogger;

  FirebaseLogger({required this.isDebug, this.externalLogger});

  void log(String message) {
    if (isDebug) {
      debugPrint('🔥 [FIREBASE] $message');
    }
  }

  void logError(String error) {
    if (isDebug) {
      debugPrint('🚨 [FIREBASE ERROR] $error');
    } else {
      externalLogger?.call(error);
    }
  }
}
