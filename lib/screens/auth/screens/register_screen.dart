import 'package:flutter/material.dart';
import 'package:money_laundry/screens/auth/exceptions/register_exception.dart';
import 'package:money_laundry/screens/auth/services/auth_service.dart';
import 'package:money_laundry/widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => isLoading = true);

    try {
      await authService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
        phoneController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Register berhasil"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } on RegisterException catch (e) {
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
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6594B1),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF6594B1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6594B1),
                      ),
                    ),

                    const SizedBox(height: 25),

                    CustomInput(
                      label: "Full Name",
                      controller: nameController,
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 15),

                    CustomInput(
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 15),

                    CustomInput(
                      label: "Phone Number",
                      controller: phoneController,
                      icon: Icons.phone,
                    ),

                    const SizedBox(height: 15),

                    CustomInput(
                      label: "Password",
                      controller: passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),

                    const SizedBox(height: 15),

                    CustomInput(
                      label: "Confirm Password",
                      controller: confirmPasswordController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6594B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
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