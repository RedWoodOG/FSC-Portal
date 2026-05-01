import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Production-grade logger that works in both debug and release modes.
/// - Debug: prints to console
/// - Release: writes errors and warnings to a log file
class Log {
  static File? _logFile;
  static bool _initialized = false;

  static Future<void> _ensureInitialized() async {
    if (_initialized) return;
    _initialized = true;
    try {
      final dir = await getApplicationDocumentsDirectory();
      _logFile = File(p.join(dir.path, 'portal_offline.log'));
    } catch (_) {
      // If we can't get the documents dir, file logging is unavailable
    }
  }

  static void _writeToFile(String level, String message) {
    if (_logFile == null) return;
    try {
      final timestamp = DateTime.now().toIso8601String();
      _logFile!.writeAsStringSync(
        '[$timestamp] $level: $message\n',
        mode: FileMode.append,
      );
    } catch (_) {
      // Silently fail — logging must never crash the app
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('INFO: $message');
    }
  }

  static void warn(String message) {
    if (kDebugMode) {
      print('WARN: $message');
    }
    // Warnings are logged to file in all modes
    _writeToFile('WARN', message);
  }

  static void debug(String message) {
    if (kDebugMode) {
      print('DEBUG: $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('ERROR: $message');
      if (error != null) print(error);
      if (stackTrace != null) print(stackTrace);
    }
    // Errors are always logged to file regardless of build mode
    final fullMessage = [
      message,
      if (error != null) error.toString(),
      if (stackTrace != null) stackTrace.toString(),
    ].join('\n');
    _writeToFile('ERROR', fullMessage);
  }

  /// Call once at app startup to initialize file logging
  static Future<void> initialize() async {
    await _ensureInitialized();
  }
}
