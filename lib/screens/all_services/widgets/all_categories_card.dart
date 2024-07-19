import 'package:flutter/material.dart';

class AllCategoriesCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Function()? onTap;

  const AllCategoriesCard(
      {super.key, required this.iconPath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      splashColor: Colors.blue.shade100,
      child: Column(
        children: [
          Container(
            width: 110,
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 2),
                  ),
                ]),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
