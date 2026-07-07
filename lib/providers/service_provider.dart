import 'package:flutter/material.dart';
import 'package:money_laundry/models/service.dart';
import 'package:money_laundry/services/api_service.dart';
import 'package:money_laundry/services/cache_service.dart';

class ServiceProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final ServiceCacheService _cacheService = ServiceCacheService();

  List<Service> _services = [];
  List<Service> get services => _services;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _usingOfflineCache = false;
  bool get usingOfflineCache => _usingOfflineCache;

  Future<void> fetchServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ambil data dari Firestore
      final services = await _apiService.getServices();

      _services = services;

      // Simpan ke SQLite
      await _cacheService.saveServices(services);

      _usingOfflineCache = false;
    } catch (e) {
      debugPrint("Firestore gagal : $e");
      debugPrint("Menggunakan cache SQLite");

      try {
        _services = await _cacheService.getServices();

        _usingOfflineCache = true;

        if (_services.isEmpty) {
          _error = "Tidak ada data layanan.";
        }
      } catch (cacheError) {
        _error = cacheError.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
