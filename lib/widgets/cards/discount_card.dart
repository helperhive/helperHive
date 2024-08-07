import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class DiscountCard extends StatelessWidget {
  final String service;
  final String code;
  final String discount;
  final String imagePath;
  final Function()? onTap;
  const DiscountCard(
      {super.key,
      required this.service,
      required this.code,
      required this.discount,
      required this.imagePath,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Colors.white,
            height: 170,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        spreadRadius: 2,
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Get $discount% on $service',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CODE: $code',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
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
          Positioned(
              right: -1,
              top: 0,
              child: SizedBox(
                height: 160,
                width: 120,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}
