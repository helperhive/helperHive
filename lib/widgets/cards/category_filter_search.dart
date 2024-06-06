import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';

class CategoryFilter extends StatelessWidget {
  final Function(String) onSelectCategory;
  final String selectedCategory;

  const CategoryFilter({
    super.key,
    required this.onSelectCategory,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryButton(
              icon: Icons.miscellaneous_services,
              label: 'All',
              isSelected: selectedCategory == 'All',
              onPressed: () => onSelectCategory('All'),
            ),
            CategoryButton(
              icon: Icons.build_circle_sharp,
              label: 'Repair',
              isSelected: selectedCategory == 'Repair',
              onPressed: () => onSelectCategory('Repair'),
            ),
            CategoryButton(
              icon: Icons.local_laundry_service_sharp,
              label: 'Washing',
              isSelected: selectedCategory == 'Washing',
              onPressed: () => onSelectCategory('Washing'),
            ),
            CategoryButton(
              icon: Icons.plumbing,
              label: 'Plumbing',
              isSelected: selectedCategory == 'Plumbing',
              onPressed: () => onSelectCategory('Plumbing'),
            ),
            CategoryButton(
              icon: Icons.cleaning_services,
              label: 'Cleaning',
              isSelected: selectedCategory == 'Cleaning',
              onPressed: () => onSelectCategory('Cleaning'),
            ),
            CategoryButton(
              icon: Icons.format_paint_outlined,
              label: 'Painting',
              isSelected: selectedCategory == 'Painting',
              onPressed: () => onSelectCategory('Painting'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? blueColor : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
