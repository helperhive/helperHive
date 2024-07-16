import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_services/widgets/all_categories_card.dart';

import '../search/service_search_screen.dart';

class AllCategoriesColumn extends StatelessWidget {
  const AllCategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> categoryIcons = {
      'Cleaning': Icons.cleaning_services,
      'Washing': Icons.local_laundry_service,
      'Repair': Icons.build,
      'Painting': Icons.format_paint,
      'Plumbing': Icons.plumbing,
      'Healthcare': Icons.local_hospital,
      'Real Estate': Icons.home,
      'Transportation': Icons.directions_car,
      'Pest Control': Icons.bug_report,
      'Saloon': Icons.content_cut,
      'Food and Beverage': Icons.local_dining,
      'Beauty and Spa': Icons.spa,
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
            const SizedBox(height: 30), // Adjust height as needed for spacing
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
                  final IconData icon = categoryIcons.values.elementAt(index);

                  return AllCategoriesCard(
                    icon: icon,
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
