import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/screens/home/list_order_screen/order_detail_screen.dart';
import 'package:provider/provider.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white : const Color(0xFF1F2937));
    final secondaryColor = isDark ? Colors.white70 : const Color(0xFF64748B);
    final cardColor = theme.cardColor;
    final appBarColor = theme.appBarTheme.backgroundColor;
    final scaffoldBackground = theme.scaffoldBackgroundColor;
    final orderProvider = context.read<OrderProvider>();

    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          "List Order",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
      ),

      body: StreamBuilder(
        stream: orderProvider.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Terjadi kesalahan mengambil data"),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Text(
                "Belum ada order yang dibuat",
                style: TextStyle(fontSize: 16, color: secondaryColor),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.18 : 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailScreen(order: order),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF6FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: Color(0xFF2F5274),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.customerName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    order.customerPhone,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(
                                        order.status,
                                      ).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: _getStatusColor(order.status),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Rp ${NumberFormat('#,###', 'id_ID').format(order.total)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Proses':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
