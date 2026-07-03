import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_model.dart';

class CustomerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collection = "customers";

  /// CREATE
  Future<void> addCustomer({
    required String name,
    required String phone,
  }) async {
    await _firestore.collection(collection).add({'name': name, 'phone': phone});
  }

  /// READ
  Stream<List<CustomerModel>> getCustomers() {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomerModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  /// UPDATE
  Future<void> updateCustomer(CustomerModel customer) async {
    await _firestore
        .collection(collection)
        .doc(customer.id)
        .update(customer.toMap());
  }

  /// DELETE
  Future<void> deleteCustomer(String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }
}
