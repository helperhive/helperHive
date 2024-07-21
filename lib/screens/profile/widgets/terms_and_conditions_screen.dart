import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
