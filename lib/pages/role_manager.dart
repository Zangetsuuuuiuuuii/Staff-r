import 'package:flutter/material.dart';

/// Enum representing the user's role
enum UserRole { client, professional }

/// Global RoleManager with ChangeNotifier
class RoleManager extends ChangeNotifier {
  UserRole _role = UserRole.professional;
  String? _currentRole;

  /// Returns the current role
  UserRole get role => _role;

  /// Returns true if current role is Client
  bool get isClient => _role == UserRole.client;

  /// Returns true if current role is Professional
  bool get isProfessional => _role == UserRole.professional;

  /// Switch role to client
  void switchToClient() {
    _role = UserRole.client;
    notifyListeners();
  }

  /// Switch role to professional
  void switchToProfessional() {
    _role = UserRole.professional;
    notifyListeners();
  }

  /// Toggle between client and professional roles
  void toggleRole() {
    _role = _role == UserRole.client
        ? UserRole.professional
        : UserRole.client;
    notifyListeners();
  }

  String? get currentRole => _currentRole;

  Future<void> setRole(String role) async {
    _currentRole = role;
    notifyListeners();
  }

  void clearRole() {
    _currentRole = null;
    notifyListeners();
  }
}
