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
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 1,
      child: Container(
        color: backgroundColor,
        height: 90,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: blueColor),
              const SizedBox(height: 8.0),
              Text(label,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
