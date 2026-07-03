import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_laundry/models/service.dart';

class OrderModel {
  final String? id;
  final String customerName;
  final String customerPhone;
  final List<Service> services;
  final int total;
  String status;
  final DateTime createdAt;

  OrderModel({
    this.id,
    required this.customerName,
    required this.customerPhone,
    required this.services,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OrderModel(
      id: documentId,
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      services: (map['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e))
          .toList(),
      total: map['total'] ?? 0,
      status: map['status'] ?? 'Pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerPhone': customerPhone,
      'services': services.map((e) => e.toJson()).toList(),
      'total': total,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
