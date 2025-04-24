import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _firstName;
  String? _lastName;
  String? _email;

  bool get isLoggedIn => _isLoggedIn;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;

  Future<bool> login(String username, String password) async {
    final response = await AuthService.login(username, password);
    _isLoggedIn = response != null;

    if (_isLoggedIn) {
      _firstName = response!['firstName'];
      _lastName = response['lastName'];
      _email = response['email'];
    }

    notifyListeners();
    return _isLoggedIn;
  }

  Future<void> logout() async {
    await AuthService.logout();
    _isLoggedIn = false;
    _firstName = null;
    _lastName = null;
    _email = null;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    _isLoggedIn = await AuthService.isLoggedIn();
    if (_isLoggedIn) {
      _firstName = await AuthService.getFirstName();
      _lastName = await AuthService.getLastName();
      _email = await AuthService.getEmail();
    }
    notifyListeners();
  }
}
