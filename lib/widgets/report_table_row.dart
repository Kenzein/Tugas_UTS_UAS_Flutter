import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_laundry/models/order_model.dart';

class ReportTableRow extends StatelessWidget {
  final OrderModel order;

  const ReportTableRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("dd/MM/yy").format(order.createdAt);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffE5E5E5))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date
          Expanded(
            flex: 2,
            child: Text(date, style: const TextStyle(fontSize: 12)),
          ),

          // Customer
          Expanded(
            flex: 3,
            child: Text(
              order.customerName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          // Services
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.services
                  .map(
                    (service) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "• ${service.name}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Total
          Expanded(
            flex: 2,
            child: Text(
              "Rp ${NumberFormat('#,###', 'id_ID').format(order.total)}",
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
