import 'package:flutter/material.dart';
import 'package:helperhive/widgets/cards/category_card.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryCard(icon: Icons.local_laundry_service, label: 'Washing'),
            CategoryCard(icon: Icons.build_circle_sharp, label: 'Repair'),
            CategoryCard(icon: Icons.format_paint_outlined, label: 'Painting'),
            CategoryCard(icon: Icons.plumbing_outlined, label: 'Plumbing'),
            CategoryCard(icon: Icons.cleaning_services, label: 'Cleaning'),
            CategoryCard(
                icon: Icons.miscellaneous_services, label: 'All Services'),
          ],
        ),
      ),
    );
  }
}
