import 'package:flutter/material.dart';
import 'package:helperhive/screens/all_categories_screen.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> subcategories;

  const CategoryCard(
      {super.key,
      required this.icon,
      required this.label,
      required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SubcategoriesPage(subcategories);
          },
        ).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have selected $value')),
          );
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Background color
              borderRadius: BorderRadius.circular(15), // Border radius
            ),
            padding: const EdgeInsets.all(
                10), // Padding to adjust the icon within the container
            child: Icon(icon,
                size: 25, color: Colors.white), // Icon with white color
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
