import 'package:money_laundry/screens/auth/exceptions/login_exception.dart';
import 'package:money_laundry/screens/auth/exceptions/register_exception.dart';

class AuthService {
  // Login Method
  void login(String email, String password) {
    if (email.isEmpty) {
      throw LoginException('Email tidak boleh kosong');
    }

    if (!email.contains('@')) {
      throw LoginException('Format email tidak valid');
    }

    if (password.isEmpty) {
      throw LoginException('Password tidak boleh kosong');
    }

    if (password.length < 6) {
      throw LoginException('Password minimal memiliki 6 karakter');
    }

    if (email != "user@gmail.com" || password != "123456") {
      throw LoginException('Email atau password salah');
    }
  }

  // Register Method
  void register(
    String email,
    String password,
    String confirmPassword,
    String phone,
  ) {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      throw RegisterException('Semua data wajib diisi');
    }

    if (!email.contains('@')) {
      throw RegisterException('Format email tidak valid');
    }

    if (password.length < 6) {
      throw RegisterException('Password minimal memiliki 6 karakter');
    }

    if (password != confirmPassword) {
      throw RegisterException('Password tidak sama');
    }

    if (phone.length < 10) {
      throw RegisterException('Nomor HP tidak valid');
    }
  }
}
