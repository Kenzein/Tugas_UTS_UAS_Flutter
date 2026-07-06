import 'package:flutter/material.dart';
import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/widgets/report_table_header.dart';
import 'package:money_laundry/widgets/report_table_row.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final secondaryColor = isDark ? Colors.white70 : const Color(0xFF64748B);
    final appBarColor = theme.appBarTheme.backgroundColor;
    final scaffoldBackground = theme.scaffoldBackgroundColor;
    final orderProvider = context.read<OrderProvider>();

    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          "Transaction Report",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
      ),

      body: StreamBuilder<List<OrderModel>>(
        stream: orderProvider.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Belum ada transaksi",
                style: TextStyle(color: secondaryColor),
              ),
            );
          }

          final orders = snapshot.data!;
          final totalOrder = orders.length;
          final totalRevenue = orders.fold(0, (sum, item) => sum + item.total);

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.18 : 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        context,
                        title: 'Total Order',
                        value: '$totalOrder',
                        icon: Icons.receipt_long,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        context,
                        title: 'Revenue',
                        value:
                            'Rp ${NumberFormat('#,###', 'id_ID').format(totalRevenue)}',
                        icon: Icons.attach_money,
                      ),
                    ),
                  ],
                ),
              ),
              const ReportTableHeader(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.18 : 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return ReportTableRow(order: orders[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _SummaryCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white70 : const Color(0xFF64748B);
    final valueColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF2F5274),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
