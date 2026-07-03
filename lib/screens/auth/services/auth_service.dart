import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/login_exception.dart';
import '../exceptions/register_exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  User? get currentUser => _auth.currentUser;


  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty) {
      throw LoginException("Email tidak boleh kosong");
    }

    if (!email.contains("@")) {
      throw LoginException("Format email tidak valid");
    }

    if (password.isEmpty) {
      throw LoginException("Password tidak boleh kosong");
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw LoginException("Email tidak ditemukan");

        case "wrong-password":
          throw LoginException("Password salah");

        case "invalid-email":
          throw LoginException("Format email tidak valid");

        case "invalid-credential":
          throw LoginException("Email atau password salah");

        case "user-disabled":
          throw LoginException("Akun telah dinonaktifkan");

        case "network-request-failed":
          throw LoginException("Tidak dapat terhubung ke server.");

        default:
          throw LoginException(
            e.message ?? "Terjadi kesalahan saat login",
          );
      }
    } catch (_) {
      throw LoginException("Terjadi kesalahan saat login");
    }
  }

  
  Future<void> register(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
  ) async {
    // Validasi
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.trim().isEmpty) {
      throw RegisterException("Semua data wajib diisi");
    }

    if (!email.contains("@")) {
      throw RegisterException("Format email tidak valid");
    }

    if (password.length < 6) {
      throw RegisterException("Password minimal 6 karakter");
    }

    if (password != confirmPassword) {
      throw RegisterException("Konfirmasi password tidak sesuai");
    }

    try {
      // Membuat akun Firebase Authentication
      UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Menyimpan data user ke Firestore
      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set({
        "uid": credential.user!.uid,
        "name": name.trim(),
        "email": email.trim(),
        "phone": phone.trim(),
        "photo": "",
        "createdAt": Timestamp.now(),
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw RegisterException("Email sudah digunakan");

        case "weak-password":
          throw RegisterException("Password terlalu lemah");

        case "invalid-email":
          throw RegisterException("Format email tidak valid");

        case "network-request-failed":
          throw RegisterException("Tidak dapat terhubung ke server.");

        default:
          throw RegisterException(
            e.message ?? "Gagal melakukan register",
          );
      }
    } catch (_) {
      throw RegisterException(
        "Terjadi kesalahan saat register",
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}