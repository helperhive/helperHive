import 'package:flutter/material.dart';

//at to done the payment screen
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'Payment',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ));
  }
}
