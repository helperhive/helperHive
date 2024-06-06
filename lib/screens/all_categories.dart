import 'package:flutter/material.dart';

class AllCategoriesColumn extends StatelessWidget {
  final Map<String, IconData> categoryIcons = {
    'Healthcare': Icons.local_hospital,
    'Real Estate': Icons.home,
    'Transportation': Icons.directions_car,
    'Pest Control': Icons.bug_report,
    'Beauty and Spa': Icons.spa,
    'Saloon': Icons.content_cut,
    'Food and Beverage': Icons.local_dining,
    'Washing': Icons.local_laundry_service,
    'Repairs': Icons.build,
    'Painting': Icons.format_paint,
    'Plumbing': Icons.plumbing,
    'Cleaning': Icons.cleaning_services,
  };

  final Map<String, List<String>> categorySubcategories = {
    'Healthcare': [
      'Nursing',
      'Medical Coding',
      'Physical Therapy',
      'Medical Research'
    ],
    'Real Estate': [
      'Property Management',
      'Real Estate Development',
      'Appraisal',
      'Leasing'
    ],
    'Transportation': [
      'Logistics',
      'Delivery',
      'Public Transit',
      'Fleet Management'
    ],
    'Food and Beverage': [
      'Restaurant Management',
      'Catering',
      'Food Processing',
      'Beverage Production'
    ],
    'Pest Control': [
      'Residential Pest Control',
      'Commercial Pest Control',
      'Termite Control',
      'Rodent Control'
    ],
    'Beauty and Spa': [
      'Skin Care',
      'Massage Therapy',
      'Hair Treatment',
      'Manicure and Pedicure'
    ],
    'Saloon': [
      'Haircut',
      'Hair Coloring',
      'Styling',
      'Beard Grooming',
    ],
    'Washing': [
      'Laundry Service',
      'Dry Cleaning',
      'Car Wash',
      'Carpet Cleaning'
    ],
    'Repairs': [
      'AC Repair',
      'Geyser Repair',
      'Washing Machine Repair',
      'Fridge Repair'
    ],
    'Painting': [
      'Interior Painting',
      'Exterior Painting',
      'Commercial Painting',
      'Residential Painting'
    ],
    'Plumbing': [
      'Leak Repair',
      'Drain Cleaning',
      'Pipe Installation',
      'Water Heater Repair'
    ],
    'Cleaning': [
      'House Cleaning',
      'Office Cleaning',
      'Window Cleaning',
      'Carpet Cleaning'
    ],
  };

  AllCategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
            final List<String> subcategories =
                categorySubcategories[label] ?? [];

            return AllCategoryCard(
              icon: icon,
              label: label,
              subcategories: subcategories,
            );
          },
        ),
      ),
    );
  }
}

class AllCategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> subcategories;

  const AllCategoryCard(
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
          showDragHandle: true,
          isScrollControlled: false,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.3,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.8, // Set the maximum height here
                  ),
                  child: SubcategoriesPage(subcategories),
                );
              },
            );
          },
        );
      },
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
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

class SubcategoriesPage extends StatelessWidget {
  final List<String> subcategories;

  const SubcategoriesPage(this.subcategories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(subcategories[index]),
              onTap: () {
                Navigator.pop(context, subcategories[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
