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
              label: 'All',
              isSelected: selectedCategory == 'All',
              onPressed: () => onSelectCategory('All'),
            ),
            CategoryButton(
              label: 'Cleaning',
              isSelected: selectedCategory == 'Cleaning',
              onPressed: () => onSelectCategory('Cleaning'),
            ),
            CategoryButton(
              label: 'Repair',
              isSelected: selectedCategory == 'Repair',
              onPressed: () => onSelectCategory('Repair'),
            ),
            CategoryButton(
              label: 'Washing',
              isSelected: selectedCategory == 'Washing',
              onPressed: () => onSelectCategory('Washing'),
            ),
            CategoryButton(
              label: 'Plumbing',
              isSelected: selectedCategory == 'Plumbing',
              onPressed: () => onSelectCategory('Plumbing'),
            ),
            CategoryButton(
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
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? blueColor : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
