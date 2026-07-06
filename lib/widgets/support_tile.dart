import 'package:flutter/material.dart';

class SupportTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const SupportTile({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EEF5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F5274).withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xFFEEF6FF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(color: Color(0xFF64748B)),
              )
            : null,
        trailing: onTap != null
            ? const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF2F5274))
            : null,
        onTap: onTap,
      ),
    );
  }
}
