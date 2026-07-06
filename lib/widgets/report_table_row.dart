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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F4F8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ),

          // Customer
          Expanded(
            flex: 3,
            child: Text(
              order.customerName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF475569),
                        ),
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
                color: Color(0xFF0F766E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
