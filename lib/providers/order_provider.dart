import 'package:flutter/material.dart';
import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/models/service.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  void addOrder(List<Service> services) {
    int total = 0;

    for (final service in services) {
      total += service.price;
    }
    _orders.add(
      OrderModel(
        services: List.from(services),
        total: total,
        createdAt: DateTime.now(),
        status: "Pending",
      ),
    );
  }

  void deleteOrder(int index) {
    _orders.removeAt(index);
    notifyListeners();
  }
}
