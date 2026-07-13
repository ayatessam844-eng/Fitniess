import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.requiredMessage,
    required this.keyboardType,
    this.obscureText = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String requiredMessage;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return requiredMessage;
        }
        return null;
      },
    );
  }
}
