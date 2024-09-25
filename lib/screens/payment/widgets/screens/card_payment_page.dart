import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardPaymentPage extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();

  CardPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              controller: cardNumberController,
              labelText: 'Card Number',
              keyboardType: TextInputType.number,
              maxLength: 16,
              validator: (value) => value!.isEmpty || value.length != 16
                  ? 'Enter a valid card number'
                  : null,
            ),
            _buildTextField(
              controller: expiryDateController,
              labelText: 'Expiry Date',
              hintText: 'MM/YY',
              keyboardType: TextInputType.datetime,
              maxLength: 5,
              validator: (value) => value!.isEmpty ||
                      !RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)
                  ? 'Enter a valid expiry date'
                  : null,
            ),
            _buildTextField(
              controller: cvvController,
              labelText: 'CVV',
              keyboardType: TextInputType.number,
              maxLength: 3,
              obscureText: true,
              validator: (value) => value!.isEmpty || value.length != 3
                  ? 'Enter a valid CVV'
                  : null,
            ),
            _buildTextField(
              controller: cardHolderNameController,
              labelText: 'Card Holder Name',
              keyboardType: TextInputType.text,
              validator: (value) =>
                  value!.isEmpty ? 'Enter the card holder name' : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_validateInputs(context)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentSuccessfull()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue.shade900, width: 2),
                ),
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            hintText: hintText,
            counterText: '',
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLength: maxLength,
          onChanged: (value) {
            if (validator != null) {
              validator(value);
            }
          },
        ),
      ),
    );
  }

  bool _validateInputs(BuildContext context) {
    String cardNumber = cardNumberController.text;
    String expiryDate = expiryDateController.text;
    String cvv = cvvController.text;
    String cardHolderName = cardHolderNameController.text;

    if (cardNumber.isEmpty ||
        cardNumber.length != 16 ||
        !RegExp(r'^[0-9]{16}$').hasMatch(cardNumber)) {
      _showErrorDialog(context, 'Please enter a valid card number.');
      return false;
    }

    if (expiryDate.isEmpty ||
        !RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(expiryDate)) {
      _showErrorDialog(context, 'Please enter a valid expiry date.');
      return false;
    }

    if (cvv.isEmpty ||
        cvv.length != 3 ||
        !RegExp(r'^[0-9]{3}$').hasMatch(cvv)) {
      _showErrorDialog(context, 'Please enter a valid CVV.');
      return false;
    }

    if (cardHolderName.isEmpty) {
      _showErrorDialog(context, 'Please enter the card holder name.');
      return false;
    }

    return true;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class PaymentSuccessfull extends StatelessWidget {
  const PaymentSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Screen'),
      ),
      body: Center(
        child: Lottie.asset(
          'assets/animations/tick.json', // Local Lottie animation file
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          repeat: false,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CardPaymentPage(),
  ));
}
