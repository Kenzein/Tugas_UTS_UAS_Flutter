import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../services/customer_service.dart';

class CustomerProvider extends ChangeNotifier {
  final CustomerService _service = CustomerService();

  List<CustomerModel> customers = [];

  void listenCustomers() {
    _service.getCustomers().listen((data) {
      customers = data;
      notifyListeners();
    });
  }

  Future<void> addCustomer({
    required String name,
    required String phone,
  }) async {
    await _service.addCustomer(name: name, phone: phone);
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    await _service.updateCustomer(customer);
  }

  Future<void> deleteCustomer(String id) async {
    await _service.deleteCustomer(id);
  }
}
