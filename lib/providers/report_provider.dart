import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  int _totalOrders = 0;
  double _totalRevenue = 0;

  int get totalOrders => _totalOrders;
  double get totalRevenue => _totalRevenue;

  void generateReport(List<Map<String, dynamic>> orders) {
    _totalOrders = orders.length;

    _totalRevenue = orders.fold(0, (sum, order) => sum + order["total"]);

    notifyListeners();
  }
}
