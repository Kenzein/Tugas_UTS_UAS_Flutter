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
    final orderProvider = context.read<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction Report",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6594B1),
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
            return const Center(child: Text("Belum ada transaksi"));
          }

          final orders = snapshot.data!;

          final totalOrder = orders.length;

          final totalRevenue = orders.fold(0, (sum, item) => sum + item.total);

          return Column(
            children: [
              const ReportTableHeader(),

              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return ReportTableRow(order: orders[index]);
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: const Border(top: BorderSide(color: Colors.grey)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Order",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$totalOrder",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Revenue",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rp ${NumberFormat('#,###', 'id_ID').format(totalRevenue)}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
