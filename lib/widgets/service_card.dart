import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String discount;
  final String serviceName;
  final String price;
  final String providerName;
  final double rating;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.discount,
    required this.serviceName,
    required this.price,
    required this.providerName,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 1.0,
        // margin: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          color: backgroundColor,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 110,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$discount% discount",
                          style: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          serviceName,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "$price \$ /hour ",
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
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
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 24.0),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
