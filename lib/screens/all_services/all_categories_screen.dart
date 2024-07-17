import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_services/widgets/all_categories_card.dart';

import '../search/service_search_screen.dart';

class AllCategoriesColumn extends StatelessWidget {
  const AllCategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> categoryIcons = {
      'Cleaning': 'assets/service_icons/cleaning.png',
      'Washing': 'assets/service_icons/washing.png',
      'Repair': 'assets/service_icons/repair.png',
      'Painting': 'assets/service_icons/painter.png',
      'Plumbing': 'assets/service_icons/plumbing.png',
      'Healthcare': 'assets/service_icons/healthcare.png',
      'Carpenter': 'assets/service_icons/carpenter.png',
      'Electrician': 'assets/service_icons/electrician.png',
      'PestXpert': 'assets/service_icons/pest_control.png',
      'Saloon': 'assets/service_icons/saloon.png',
      'Movers': 'assets/service_icons/movers.png',
      'Spa': 'assets/service_icons/beauty_and_spa.png',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: categoryIcons.length,
                itemBuilder: (context, index) {
                  final String label = categoryIcons.keys.elementAt(index);
                  final String iconPath = categoryIcons.values.elementAt(index);

                  return AllCategoriesCard(
                    iconPath: iconPath,
                    label: label,
                    onTap: () {
                      // Navigate to CategoryFilterSearch with the selected category
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ServiceSearchScreen(
                                sevice: label,
                              )));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
