import 'package:flutter/material.dart';
import 'package:money_laundry/screens/auth/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {

      await _authService.login(email, password);

      _isLoggedIn = true;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    _isLoggedIn = false;

    notifyListeners();
  }

  Future<void> checkLogin() async {
    _isLoggedIn = _authService.currentUser != null;
    notifyListeners();
  }
}