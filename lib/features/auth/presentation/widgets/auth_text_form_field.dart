import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is Missing';
        }
        return null;
      },
    );
  }
}
