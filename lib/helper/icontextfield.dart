import "package:flutter/material.dart";

class IconTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const IconTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hint,
        prefixIcon: Icon(icon),
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          fontFamily: "Roboto Mono",
        ),
      ),
    );
  }
}
