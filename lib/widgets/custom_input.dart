import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomInput({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.icon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? isHidden : false,
      style: const TextStyle(color: Color(0xFF0F172A)),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
        ),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: const Color(0xFF64748B))
            : null,
        filled: true,
        fillColor: const Color(0xFFF4F8FD),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF94A3B8)),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF64748B),
                ),
              )
            : null,
      ),
    );
  }
}
