

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hText;
  const MyTextField({super.key,required this.controller,
    required this.obscureText, required this.hText});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey.shade300),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
