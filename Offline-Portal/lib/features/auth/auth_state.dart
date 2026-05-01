import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../../database/app_database.dart';

/// Manages authentication state for the offline portal.
/// Supports password login and optional PIN quick-reentry.
class AuthState extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLocked = false;
  DateTime? _lastActivity;
  AppDatabase? _database;

  // Lock after 15 minutes of inactivity
  static const Duration lockTimeout = Duration(minutes: 15);
  // Require full re-auth after 8 hours
  static const Duration fullReauthTimeout = Duration(hours: 8);

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLocked => _isLocked;
  bool get hasPinSet =>
      _currentUser?.pin != null && _currentUser!.pin!.isNotEmpty;

  void setDatabase(AppDatabase database) {
    _database = database;
  }

  /// Hash a password with a salt using SHA-256
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode('$salt:$password');
    return sha256.convert(bytes).toString();
  }

  /// Generate a simple salt from username + timestamp
  static String generateSalt(String username) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode('$username:$timestamp');
    return sha256.convert(bytes).toString().substring(0, 32);
  }

  /// Hash a PIN (shorter, for quick re-entry)
  static String hashPin(String pin, String salt) {
    final bytes = utf8.encode('pin:$salt:$pin');
    return sha256.convert(bytes).toString();
  }

  /// Attempt login with username and password
  Future<bool> login(String username, String password) async {
    if (_database == null) return false;

    final user = await _database!.getUserByUsername(username);
    if (user == null) return false;

    final hash = hashPassword(password, user.passwordSalt);
    if (hash != user.passwordHash) return false;

    _currentUser = user;
    _isAuthenticated = true;
    _isLocked = false;
    _lastActivity = DateTime.now();
    notifyListeners();
    return true;
  }

  /// Attempt PIN unlock (for quick re-entry)
  Future<bool> unlockWithPin(String pin) async {
    if (_currentUser == null || !hasPinSet) return false;

    final hash = hashPin(pin, _currentUser!.passwordSalt);
    if (hash != _currentUser!.pin) return false;

    _isLocked = false;
    _lastActivity = DateTime.now();
    notifyListeners();
    return true;
  }

  /// Set or update the user's PIN
  Future<bool> setPin(String pin) async {
    if (_database == null || _currentUser == null) return false;

    final hashedPin = hashPin(pin, _currentUser!.passwordSalt);
    await _database!.updateUser(UsersCompanion(
      id: Value(_currentUser!.id),
      pin: Value(hashedPin),
    ));

    // Reload user to get updated data
    _currentUser = await _database!.getUserById(_currentUser!.id);
    notifyListeners();
    return true;
  }

  /// Change the user's password
  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    if (_database == null || _currentUser == null) return false;

    // Verify current password
    final currentHash =
        hashPassword(currentPassword, _currentUser!.passwordSalt);
    if (currentHash != _currentUser!.passwordHash) return false;

    // Generate new salt and hash
    final newSalt = generateSalt(_currentUser!.username);
    final newHash = hashPassword(newPassword, newSalt);

    await _database!.updateUser(UsersCompanion(
      id: Value(_currentUser!.id),
      passwordHash: Value(newHash),
      passwordSalt: Value(newSalt),
    ));

    // If PIN was set, it's now invalid (salt changed) — clear it
    await _database!.updateUser(UsersCompanion(
      id: Value(_currentUser!.id),
      pin: const Value(null),
    ));

    _currentUser = await _database!.getUserById(_currentUser!.id);
    notifyListeners();
    return true;
  }

  /// Clear the user's PIN
  Future<void> clearPin() async {
    if (_database == null || _currentUser == null) return;

    await _database!.updateUser(UsersCompanion(
      id: Value(_currentUser!.id),
      pin: const Value(null),
    ));

    _currentUser = await _database!.getUserById(_currentUser!.id);
    notifyListeners();
  }

  /// Record user activity (resets inactivity timer)
  void recordActivity() {
    _lastActivity = DateTime.now();
  }

  /// Check if the session should be locked due to inactivity
  void checkSessionTimeout() {
    if (!_isAuthenticated || _lastActivity == null) return;

    final elapsed = DateTime.now().difference(_lastActivity!);

    if (elapsed > fullReauthTimeout) {
      // Full re-auth required
      logout();
    } else if (elapsed > lockTimeout && !_isLocked) {
      _isLocked = true;
      notifyListeners();
    }
  }

  /// Log out completely
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    _isLocked = false;
    _lastActivity = null;
    notifyListeners();
  }
}
