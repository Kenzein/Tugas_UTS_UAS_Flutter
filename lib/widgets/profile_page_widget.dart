import 'package:flutter/material.dart';

Widget buildInfoTile(IconData icon, String title, String value) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    leading: Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFEEF6FF),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFF2F5274), size: 20),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Color(0xFF1F2937),
      ),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(color: Color(0xFF64748B)),
    ),
  );
}
