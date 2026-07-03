import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_laundry/models/user_model.dart';


class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Mengambil data user yang sedang login
  Future<UserModel> getCurrentUser() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final doc =
        await _firestore.collection("users").doc(user.uid).get();

    if (!doc.exists) {
      throw Exception("Data user tidak ditemukan");
    }

    return UserModel.fromMap(doc.data()!);
  }

  /// Mengupdate profil user
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    await _firestore.collection("users").doc(user.uid).update({
      "name": name,
      "phone": phone,
    });
  }
}