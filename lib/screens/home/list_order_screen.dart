import 'package:flutter/material.dart';
import 'package:money_laundry/providers/order_provider.dart';
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
            child: ListTile(
              title: Text("Order #${index + 1}"),
              subtitle: Text(
                'Status: ${order.status}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text("Rp ${order.total}"),
            ),
          );
        },
      ),
    );
  }
}
