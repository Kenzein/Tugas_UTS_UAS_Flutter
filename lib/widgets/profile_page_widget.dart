import 'package:flutter/material.dart';

Widget buildInfoTile(IconData icon, String title, String value) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF6594B1)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(value),
  );
}
