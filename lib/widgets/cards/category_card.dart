import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      elevation: 1,
      child: Container(
        color: backgroundColor,
        height: 70,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 35, color: blueColor),
              // const SizedBox(height: 4.0),
              Text(label,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
