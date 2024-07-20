import 'package:flutter/material.dart';
// import 'package:helperhive/app/app_routes.dart';
import 'package:helperhive/screens/payment/amazon_pay_payment_page.dart';
import 'package:helperhive/screens/payment/card_payment_page.dart';
import 'package:helperhive/screens/payment/gpay_payment_page.dart';
import 'package:helperhive/screens/payment/paytm_payment_page.dart';
import 'package:helperhive/screens/payment/upi_payment_page.dart';
import 'package:helperhive/screens/payment/widgets/payment_method_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
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
              child: Image.asset('assets/payments/logo.png'), // Your logo here
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
                    assetPath: 'assets/payments/card.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardPaymentPage()));
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with UPI',
                    assetPath: 'assets/payments/upi.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UPIPaymentPage()));
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Amazon Pay',
                    assetPath: 'assets/payments/amazonpay.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AmazonPayPaymentPage()));
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Paytm',
                    assetPath: 'assets/payments/paytm.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UPIPaymentPage()));
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with PhonePe',
                    assetPath: 'assets/payments/phonepe.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaytmPaymentPage()));
                    },
                  ),
                  PaymentMethodCard(
                    title: 'Pay with Google Pay',
                    assetPath: 'assets/payments/gpay.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GPayPaymentPage()));
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