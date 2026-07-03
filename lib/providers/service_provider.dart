import 'package:flutter/material.dart';
import 'package:money_laundry/models/service.dart';
import 'package:money_laundry/services/api_service.dart';

class ServiceProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Service> _services = [];
  List<Service> get services => _services;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchServices() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _services = await _apiService.getServices();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
