import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String username, String password) async {
    final success = await AuthService.login(username, password);
    _isLoggedIn = success;
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await AuthService.logout();
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    _isLoggedIn = await AuthService.isLoggedIn();
    notifyListeners();
  }
}
