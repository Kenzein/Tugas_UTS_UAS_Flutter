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
      await Future.delayed(const Duration(seconds: 2));
      _authService.login(email, password);
      _isLoggedIn = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
