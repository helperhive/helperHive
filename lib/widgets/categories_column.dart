import 'package:flutter/material.dart';
import 'package:helperhive/widgets/category_card.dart';

class CategoriesColumn extends StatelessWidget {
  const CategoriesColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryCard(icon: Icons.cleaning_services, label: 'Cleaning'),
              CategoryCard(icon: Icons.local_laundry_service, label: 'Washing'),
              CategoryCard(icon: Icons.build_circle_sharp, label: 'Repair'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryCard(
                  icon: Icons.format_paint_outlined, label: 'Painting'),
              CategoryCard(icon: Icons.plumbing_outlined, label: 'Plumbing'),
              CategoryCard(
                  icon: Icons.miscellaneous_services, label: 'All Services'),
            ],
          ),
        ],
      ),
    );
  }
}
