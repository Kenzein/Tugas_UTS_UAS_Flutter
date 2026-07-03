import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_laundry/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:money_laundry/providers/profile_provider.dart';
import 'package:money_laundry/screens/auth/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {

    // Splash Screen tampil 2 detik
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {

      // Load data user ke Provider
      await context.read<ProfileProvider>().loadUser();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6594B1),
      body: Center(
        child: Image.asset(
          "assets/images/Logo.png",
          width: 220,
        ),
      ),
    );
  }
}