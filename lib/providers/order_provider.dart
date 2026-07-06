import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_laundry/models/order_history.dart';
import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/models/service.dart';
import 'package:money_laundry/services/history_service.dart';

class OrderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HistoryService _historyService = HistoryService();

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

  Stream<OrderModel> getOrderById(String orderId) {
    return _firestore.collection("orders").doc(orderId).snapshots().map((doc) {
      final data = doc.data()!;

      return OrderModel(
        id: doc.id,
        customerName: data["customerName"] ?? "",
        customerPhone: data["customerPhone"] ?? "",
        services: (data["services"] as List<dynamic>)
            .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        total: data["total"] ?? 0,
        status: data["status"] ?? "Pending",
        createdAt: (data["createdAt"] as Timestamp).toDate(),
      );
    });
  }

  // Future<void> updateStatus(String orderId, String status) async {
  //   // Update status di Firestore
  //   await _firestore.collection("orders").doc(orderId).update({
  //     "status": status,
  //   });

  //   if (status != "Selesai") return;

  //   final doc = await _firestore.collection("orders").doc(orderId).get();

  //   if (!doc.exists) return;

  //   final data = doc.data()!;

  //   final history = OrderHistoryModel(
  //     id: doc.id,
  //     customerName: data["customerName"] ?? "",
  //     customerPhone: data["customerPhone"] ?? "",
  //     services: (data["services"] as List)
  //         .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
  //         .toList(),
  //     total: data["total"] ?? 0,
  //     status: "Selesai",
  //     createdAt: (data["createdAt"] as Timestamp).toDate(),
  //   );

  //   await _historyService.insert(history);
  // }

  Future<void> updateStatus(String orderId, String status) async {
    print("========== UPDATE STATUS ==========");
    print("Order ID : $orderId");
    print("Status   : $status");

    try {
      await _firestore.collection("orders").doc(orderId).update({
        "status": status,
      });

      print("Firestore update berhasil");

      if (status != "Selesai") {
        print("Status bukan selesai");
        return;
      }

      print("Mengambil data order...");

      final doc = await _firestore.collection("orders").doc(orderId).get();

      print("Document exists : ${doc.exists}");

      if (!doc.exists) return;

      final data = doc.data()!;

      print("Data Firestore:");
      print(data);

      final history = OrderHistoryModel(
        id: doc.id,
        customerName: data["customerName"] ?? "",
        customerPhone: data["customerPhone"] ?? "",
        services: (data["services"] as List)
            .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        total: data["total"] ?? 0,
        status: "Selesai",
        createdAt: (data["createdAt"] as Timestamp).toDate(),
      );

      print("OrderHistory berhasil dibuat");

      await _historyService.insert(history);

      print("SQLite INSERT BERHASIL");
    } catch (e, s) {
      print("ERROR UPDATE STATUS");
      print(e);
      print(s);
    }
  }

  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection("orders").doc(orderId).delete();
  }
}
