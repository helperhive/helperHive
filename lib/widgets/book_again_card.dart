import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helperhive/constants/color_them.dart';

class BookAgainCard extends StatelessWidget {
  final String imageUrl;
  final String discount;
  final String serviceName;
  final String price;
  final String providerName;
  final double rating;

  const BookAgainCard({
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
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 1.0,
        // margin: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          color: backgroundColor,
          height: 120,
          width: 290,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 10),
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
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$discount% discount",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 20.0),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            )
                          ],
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
                        // Text('By $providerName'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
