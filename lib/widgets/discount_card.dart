import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscountCard extends StatelessWidget {
  final String service;
  final String code;
  final String discount;
  final String imagePath;
  const DiscountCard(
      {super.key,
      required this.service,
      required this.code,
      required this.discount,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white,
          height: 170,
          width: width,
          child: Card(
            color: Colors.white,
            shadowColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Get $discount% on $service',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CODE: $code',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            right: -1,
            top: -20,
            child: SizedBox(
              height: 170,
              width: 120,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }
}
