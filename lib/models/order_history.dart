import 'dart:convert';

import 'package:money_laundry/models/service.dart';

class OrderHistoryModel {
  final String id;
  final String customerName;
  final String customerPhone;
  final List<Service> services;
  final int total;
  final String status;
  final DateTime createdAt;

  OrderHistoryModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.services,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'services': jsonEncode(services.map((e) => e.toJson()).toList()),
      'total': total,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      id: map['id'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      services: (jsonDecode(map['services']) as List)
          .map((e) => Service.fromJson(e))
          .toList(),
      total: map['total'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
