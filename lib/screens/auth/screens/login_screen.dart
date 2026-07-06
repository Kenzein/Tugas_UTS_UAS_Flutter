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
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } on LoginException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan, silakan coba lagi.")),
      );
    }
  }

  Future<void> _showResetPasswordDialog() async {
    final authProvider = context.read<AuthProvider>();
    final resetEmailController = TextEditingController();
    final pageContext = context;

    await showDialog<void>(
      context: pageContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Masukkan email Anda untuk menerima link reset sandi.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: resetEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authProvider.resetPassword(
                    resetEmailController.text.trim(),
                  );

                  if (!mounted) return;

                  if (Navigator.of(dialogContext, rootNavigator: true).canPop()) {
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;

                    final messenger = ScaffoldMessenger.maybeOf(pageContext);
                    messenger?.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Link reset sandi telah dikirim ke email Anda.',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  });
                } on LoginException catch (e) {
                  if (!mounted) return;

                  final messenger = ScaffoldMessenger.maybeOf(pageContext);
                  messenger?.showSnackBar(SnackBar(content: Text(e.message)));
                } catch (e) {
                  if (!mounted) return;

                  final messenger = ScaffoldMessenger.maybeOf(pageContext);
                  messenger?.showSnackBar(
                    const SnackBar(
                      content: Text('Terjadi kesalahan, silakan coba lagi.'),
                    ),
                  );
                }
              },
              child: const Text('Kirim link reset'),
            ),
          ],
        );
      },
    );

    resetEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF2F5274),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E3C63), Color(0xFF2F5274)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Masuk untuk mengelola order, pelanggan, dan laporan Anda.",
                      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Masukkan akun Anda untuk masuk ke dashboard.",
                      style: TextStyle(fontSize: 15, color: Color(0xFF64748B), height: 1.6),
                    ),
                    const SizedBox(height: 26),
                    CustomInput(
                      label: "Email",
                      controller: emailController,
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: "Password",
                      controller: passwordController,
                      isPassword: true,
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showResetPasswordDialog,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF6594B1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6594B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          "Belum punya akun? Daftar sekarang",
                          style: TextStyle(
                            color: Color(0xFF6594B1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
