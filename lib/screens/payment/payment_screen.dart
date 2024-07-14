import 'package:flutter/material.dart';
import 'package:helperhive/screens/payment/widgets/payment_method_card.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Image.asset('assets/logo.png'), // Your logo here
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  PaymentMethodCard(
                    title: 'Pay with Card',
                    assetPath: 'assets/card.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/card_payment');
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with UPI',
                    assetPath: 'assets/upi.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/upi_payment');
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Amazon Pay',
                    assetPath: 'assets/amazonpay.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/amazon_pay_payment');
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Paytm',
                    assetPath: 'assets/paytm.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/paytm_payment');
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with PhonePe',
                    assetPath: 'assets/phonepe.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/phonepe_payment');
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Google Pay',
                    assetPath: 'assets/gpay.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/gpay_payment');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
