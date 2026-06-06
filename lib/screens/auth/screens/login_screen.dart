import 'package:flutter/material.dart';
import 'package:money_laundry/providers/auth_provider.dart';
import 'package:money_laundry/screens/auth/exceptions/login_exception.dart';
import 'package:money_laundry/screens/home/home_screen.dart';
import 'package:money_laundry/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Color(0xFF6594B1),
      body: SafeArea(
        child: Column(
          children: [
            ///TOP SECTION
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      "Hello!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      "Welcome to money laundry",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///BOTTOM CARD
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6594B1),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Custom Input
                    CustomInput(
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 15),
                    // Custom Input Pass
                    CustomInput(
                      label: 'Password',
                      controller: passwordController,
                      isPassword: true,
                      icon: Icons.lock,
                    ),

                    SizedBox(height: 25),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                try {
                                  await authProvider.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                                  if (!context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomePage(),
                                    ),
                                  );
                                } catch (e) {
                                  final message = e is LoginException
                                      ? e.message
                                      : 'Terjadi kesalahan saat login';

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6594B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterPage()),
                          );
                        },
                        child: Text(
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
