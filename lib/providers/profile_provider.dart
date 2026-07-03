import 'package:flutter/material.dart';
import 'package:money_laundry/models/user_model.dart';
import 'package:money_laundry/screens/auth/services/user_service.dart';



class ProfileProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;

  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _userService.getCurrentUser();
    } catch (e) {
      debugPrint("Profile Error : $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    await _userService.updateProfile(
      name: name,
      phone: phone,
    );

    await loadUser();
  }
}