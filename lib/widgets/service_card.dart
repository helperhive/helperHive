import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discount,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    serviceName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    price,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('By $providerName'),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16.0),
                Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
