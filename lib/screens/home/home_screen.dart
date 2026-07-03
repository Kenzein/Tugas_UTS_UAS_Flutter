import 'package:flutter/material.dart';
import 'package:money_laundry/models/user_model.dart';
import 'package:money_laundry/screens/auth/services/user_service.dart';
import 'package:money_laundry/screens/home/order_screen/order_screen.dart';
import 'package:money_laundry/screens/home/list_order_screen/list_order_screen.dart';
import 'package:money_laundry/screens/home/report_screen/report_screen.dart';
import 'package:money_laundry/widgets/app_sidebar.dart';
import 'package:money_laundry/screens/home/support_screen/support_screen.dart';
import 'package:money_laundry/widgets/menu_item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppSidebar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(110, 151, 181, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: 8000,
                          height: 8000,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Builder(
                          builder: (context) => IconButton(
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  children: [
                    FutureBuilder<UserModel>(
                      future: userService.getCurrentUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 120,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const SizedBox();
                        }

                        final user = snapshot.data!;

                        return Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome Back 👋",
                                style: TextStyle(fontSize: 16),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.3,
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
                          title: 'Support',
                          page: const SupportScreen(),
                        ),
                      ],
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
