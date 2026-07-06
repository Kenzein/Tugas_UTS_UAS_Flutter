import 'package:flutter/material.dart';
import 'package:money_laundry/models/user_model.dart';
import 'package:money_laundry/screens/auth/services/user_service.dart';
import 'package:money_laundry/screens/home/history/history_screen.dart';
import 'package:money_laundry/screens/home/order_screen/order_screen.dart';
import 'package:money_laundry/screens/home/list_order_screen/list_order_screen.dart';
import 'package:money_laundry/screens/home/report_screen/report_screen.dart';
import 'package:money_laundry/widgets/app_sidebar.dart';
import 'package:money_laundry/screens/home/support_screen/support_screen.dart';
import 'package:money_laundry/widgets/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();
  late final Future<UserModel> _currentUserFuture;

  @override
  void initState() {
    super.initState();
    _currentUserFuture = userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentDate = DateTime.now();
    final formattedDate =
        '${currentDate.day.toString().padLeft(2, '0')}/${currentDate.month.toString().padLeft(2, '0')}/${currentDate.year}';

    return Scaffold(
      endDrawer: const AppSidebar(),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1F3E5A),
                        Color(0xFF2F5274),
                        Color(0xFF163247),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF163247).withValues(alpha: 0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: const Alignment(0, 0.18),
                        child: SizedBox(
                          width: 1500,
                          height: 1500,
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Builder(
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    FutureBuilder<UserModel>(
                      future: _currentUserFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 120,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return _UserHeaderFallback(
                            formattedDate: formattedDate,
                            isDark: isDark,
                          );
                        }

                        final user = snapshot.data!;

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: isDark ? 0.22 : 0.06,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back 👋",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF64748B),
                                ),
                              ),

                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.name,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF1E293B),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.white70
                                          : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF2E3A4A),
                      ),
                    ),

                    const SizedBox(height: 14),

                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.80,
                      children: [
                        MenuItem(
                          imagePath: 'assets/images/order.jpg',
                          title: 'Order',
                          page: const OrderPage(),
                        ),
                        MenuItem(
                          imagePath: 'assets/images/listorder.jpg',
                          title: 'List Order',
                          page: const ListOrderScreen(),
                        ),
                        MenuItem(
                          imagePath: 'assets/images/report.jpg',
                          title: 'Report',
                          page: const ReportScreen(),
                        ),
                        MenuItem(
                          imagePath: 'assets/images/service.jpg',
                          title: 'History',
                          page: const HistoryScreen(),
                        ),
                        MenuItem(
                          imagePath: 'assets/images/service.jpg',
                          title: 'Support',
                          page: const SupportScreen(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _SupportKenziCard(isDark: isDark),
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

class _SupportKenziCard extends StatelessWidget {
  final bool isDark;

  const _SupportKenziCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E3A5A) : const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F5274) : const Color(0xFF6594B1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Kami',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Berikan apresiasi lewat QRIS sebagai dukungan untuk tim kami.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: isDark ? Colors.white70 : const Color(0xFF52606D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SupportScreen(showQrisOnOpen: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6594B1),
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Buka',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHeaderFallback extends StatelessWidget {
  final String formattedDate;
  final bool isDark;

  const _UserHeaderFallback({
    required this.formattedDate,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E3A5A) : const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.person_outline,
              color: isDark ? Colors.white70 : const Color(0xFF2F5274),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white70 : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pengguna',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
