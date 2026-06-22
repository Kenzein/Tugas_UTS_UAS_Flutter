import 'package:flutter/material.dart';
// import 'package:money_laundry/models/order_model.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/utils/order_status_helper.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  // final OrderModel order;
  final int index;
  const OrderDetailScreen({
    super.key,
    // required this.order,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final order = orderProvider.orders[index];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              orderProvider.updateStatus(index, value);
            },
            itemBuilder: ((context) => [
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
              const PopupMenuItem(value: 'Proses', child: Text('Proses')),
              const PopupMenuItem(value: 'Selesai', child: Text('Selesai')),
            ]),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status: ${order.status}",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: OrderStatusHelper.getColor(order.status),
              ),
            ),
            Icon(
              OrderStatusHelper.getIcon(order.status),
              color: OrderStatusHelper.getColor(order.status),
            ),
            const Divider(),
            const SizedBox(height: 10),

            const Text(
              'Services :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: order.services.length,
                itemBuilder: ((context, index) {
                  final service = order.services[index];
                  return ListTile(
                    title: Text(
                      service.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      'Rp ${service.price}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Rp ${order.total}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
