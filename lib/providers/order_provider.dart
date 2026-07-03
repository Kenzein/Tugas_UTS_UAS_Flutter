import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/models/service.dart';

class OrderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> addOrder({
    required String customerName,
    required String customerPhone,
    required List<Service> services,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      int total = 0;

      final serviceList = services.map((s) {
        total += s.price;
        return s.toJson();
      }).toList();

      final data = {
        "customerName": customerName,
        "customerPhone": customerPhone,
        "services": serviceList,
        "total": total,
        "status": "Pending",
        "createdAt": Timestamp.now(),
      };

      await _firestore.collection("orders").add(data);
    } catch (e) {
      debugPrint("Error add order: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Stream<List<OrderModel>> getOrders() {
    return _firestore
        .collection("orders")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();

            return OrderModel(
              id: doc.id,
              customerName: data["customerName"] ?? "",
              customerPhone: data["customerPhone"] ?? "",
              services: (data["services"] as List<dynamic>)
                  .map((e) => Service.fromJson(e))
                  .toList(),
              total: data["total"] ?? 0,
              status: data["status"] ?? "Pending",
              createdAt: (data["createdAt"] as Timestamp).toDate(),
            );
          }).toList();
        });
  }

  Stream<List<OrderModel>> getOrdersByDateRange(DateTime start, DateTime end) {
    return _firestore
        .collection("orders")
        .where("createdAt", isGreaterThanOrEqualTo: start)
        .where("createdAt", isLessThanOrEqualTo: end)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();

            return OrderModel(
              id: doc.id,
              customerName: data["customerName"],
              customerPhone: data["customerPhone"],
              services: [],
              total: data["total"],
              status: data["status"],
              createdAt: (data["createdAt"] as Timestamp).toDate(),
            );
          }).toList();
        });
  }

  Future<void> updateStatus(String orderId, String status) async {
    await _firestore.collection("orders").doc(orderId).update({
      "status": status,
    });
  }

  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection("orders").doc(orderId).delete();
  }
}
