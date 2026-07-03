import 'package:flutter/material.dart';
import 'package:money_laundry/screens/home/order_screen.dart';
import 'package:money_laundry/screens/home/list_order_screen.dart';
import 'package:money_laundry/screens/home/report_screen.dart';
import 'package:money_laundry/widgets/app_sidebar.dart';
import 'package:money_laundry/screens/home/support_screen.dart';
import 'package:money_laundry/widgets/menu_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    color: Color(0xFF6E97B5),
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
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Expired", style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 6),
                          const Text(
                            "26 Apr 2026",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Divider(color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text("Ken-Wash"),
                        ],
                      ),
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
                      // ERROR DIPERBAIKI: Menghapus properti yang salah dan menyisakan satu yang benar
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
                      ], // ERROR DIPERBAIKI: Menghapus satu penutup ']' yang berlebihan
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