import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final VoidCallback onTap;

  const PaymentMethodCard({super.key, 
    required this.title,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.blue.shade900, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Image.asset(assetPath, width: 40, height: 40),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        onTap: onTap,
      ),
    );
  }
}
