import 'package:flutter/material.dart';
import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/utils/order_status_helper.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Detail"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              await orderProvider.updateStatus(order.id!, value);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Pending', child: Text('Pending')),
              PopupMenuItem(value: 'Proses', child: Text('Proses')),
              PopupMenuItem(value: 'Selesai', child: Text('Selesai')),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATUS
            Row(
              children: [
                Icon(
                  OrderStatusHelper.getIcon(order.status),
                  color: OrderStatusHelper.getColor(order.status),
                ),
                const SizedBox(width: 8),
                Text(
                  "Status: ${order.status}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: OrderStatusHelper.getColor(order.status),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(),

            Text(
              "Customer",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(order.customerName),
            Text(order.customerPhone),

            const SizedBox(height: 20),

            const Text(
              "Services",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: order.services.length,
                itemBuilder: (context, index) {
                  final service = order.services[index];

                  return ListTile(
                    title: Text(service.name),
                    trailing: Text(
                      "Rp ${service.price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${order.total}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
