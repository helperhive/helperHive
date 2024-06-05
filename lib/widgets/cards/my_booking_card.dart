import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:intl/intl.dart';

class MyBookingCard extends StatelessWidget {
  final String imageUrl;
  final String time;
  final String serviceName;
  final String price;
  final String providerName;
  final DateTime date;

  const MyBookingCard({
    super.key,
    required this.imageUrl,
    required this.time,
    required this.serviceName,
    required this.price,
    required this.providerName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 1.0,
        // margin: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          color: backgroundColor,
          height: 160,
          // width: 300,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 110,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service: $serviceName",
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4.0),
                        Text(
                          "Charges: $price \$ /hour ",
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4.0),
                        Text(
                          "Date: ${DateFormat.yMMMd().format(date)}",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          "Time: $time",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),

                        // Text('By $providerName'),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: primaryColor),
                                children: [
                              const TextSpan(
                                text: ' By  ',
                              ),
                              TextSpan(
                                  text: providerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ])),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     const Icon(Icons.star, color: Colors.orange, size: 24.0),
                //     Text(
                //       date,
                //       style: const TextStyle(fontSize: 18.0),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
