import 'package:money_laundry/models/service.dart';

class OrderModel {
  final List<Service> services;
  final int total;
  final DateTime createdAt;
  final String status;

  OrderModel({
    required this.services,
    required this.total,
    required this.createdAt,
    required this.status,
  });
}
