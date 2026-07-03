import 'package:flutter/material.dart';
import 'package:money_laundry/providers/auth_provider.dart';
import 'package:money_laundry/screens/auth/exceptions/login_exception.dart';
import 'package:money_laundry/screens/auth/screens/register_screen.dart';
import 'package:money_laundry/screens/home/home_screen.dart';
import 'package:money_laundry/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } on LoginException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan, silakan coba lagi."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF6594B1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Hello!",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Welcome to Money Laundry",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6594B1),
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomInput(
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 15),

                    CustomInput(
                      label: "Password",
                      controller: passwordController,
                      isPassword: true,
                      icon: Icons.lock,
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6594B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>  RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            color: Color(0xffFF714B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}