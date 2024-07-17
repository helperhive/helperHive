import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_services/all_categories_screen.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => label == 'All Services'
          ? Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AllCategoriesColumn()))
          : Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServiceSearchScreen(
                    sevice: label,
                  ))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 4),
                          spreadRadius: 1,
                          blurRadius: 8)
                    ]),
                child: Icon(icon, size: 42, color: blueColor),
              ),
            ),
            // const SizedBox(height: 4.0),
            Text(label,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
