import 'package:flutter/material.dart';

class OrderStatusHelper {
  static Color getColor(String status) {
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

  static IconData getIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Proses':
        return Icons.local_laundry_service;
      case 'Selesai':
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }

  static int getStatusPriority(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Proses':
        return 1;
      case 'Selesai':
        return 2;
      default:
        return 99;
    }
  }
}
