import 'package:flutter/material.dart';
import 'package:tutorial_management/helper/icontextfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcom to Home Tutor Center",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 5),
          Text(
            "Login",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          IconTextField(hint: 'Email', icon: Icons.email),
          const SizedBox(height: 20),
          IconTextField(
            hint: 'Password',
            icon: Icons.password,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
