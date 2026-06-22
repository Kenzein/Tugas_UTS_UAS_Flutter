import 'package:flutter/material.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/screens/home/list_order_screen/order_detail_screen.dart';
import 'package:provider/provider.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Order",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        backgroundColor: Color(0xFF6594B1),
      ),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          final order = orderProvider.orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailScreen(index: index),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order #${index + 1}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(order.status),
                      ),
                    ),
                    Text('Rp ${order.total}'),
                  ],
                ),
              ),
            ),
          );
          // return Card(
          //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: ListTile(
          //     title: Text(
          //       "Order #${index + 1}",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           order.status,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: getStatusColor(order.status),
          //           ),
          //         ),
          //         Text('Rp ${order.total}'),
          //       ],
          //     ),
          //     onTap: () {
          //       print('Order Detail');
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (_) => OrderDetailScreen(order: order),
          //         ),
          //       );
          //     },

          //     trailing:
          //     // PopupMenuButton(
          //     //   onSelected: (value) {
          //     //     orderProvider.updateStatus(index, value);
          //     //   },
          //     //   itemBuilder: ((context) => [
          //     //     const PopupMenuItem(value: 'Pending', child: Text('Pending')),
          //     //     const PopupMenuItem(value: 'Proses', child: Text('Proses')),
          //     //     const PopupMenuItem(value: 'Selesai', child: Text('Selesai')),
          //     //   ]),
          //     // ),
          //   ),
          // );
        },
      ),
    );
  }

  Color getStatusColor(String status) {
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
