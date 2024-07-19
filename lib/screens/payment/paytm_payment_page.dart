import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // For using Lottie animations

class PaytmPaymentPage extends StatefulWidget {
  const PaytmPaymentPage({super.key});

  @override
  _PaytmPaymentPageState createState() => _PaytmPaymentPageState();
}

class _PaytmPaymentPageState extends State<PaytmPaymentPage> {
  void _payWithPaytm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmptyScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paytm Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Payment Details',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Paytm Mobile Number',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Payment Type',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: ['Wallet', 'UPI'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle payment type change
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _payWithPaytm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.blue.shade900, width: 2),
              ),
              child: const Text('Pay with Paytm'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
      ),
      body: Center(
        child: Lottie.asset(
          'assets/animations/tick.json', // Your Lottie animation file
          width: 200,
          height: 200,
          repeat: false,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PaytmPaymentPage(),
  ));
}
