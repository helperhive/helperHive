import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(icon, size: 42, color: blueColor),
              )),
          // const SizedBox(height: 4.0),
          Text(label,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
