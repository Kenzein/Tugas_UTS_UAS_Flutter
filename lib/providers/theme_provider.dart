import 'package:flutter/material.dart';
import 'package:money_laundry/services/shared_pref_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPrefService _prefService = SharedPrefService();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final isDark = await _prefService.getTheme();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  Future<void> toggleTheme(bool enabled) async {
    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;

    await _prefService.saveTheme(enabled);

    notifyListeners();
  }
}
