import 'package:flutter/material.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/all_services/all_categories_screen.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    super.key,
  });

  final List<Service> displayedServices = const [
    Service.repair,
    Service.painting,
    Service.plumbing,
    Service.cleaning,
    Service.washing,
    Service.others, // This will be map to "All Services"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: displayedServices.map((service) {
            return CategoryCard(
              icon: service == Service.others
                  ? 'assets/service_icons/all_services.png'
                  : getAssetForService(service),
              label: service,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon;
  final Service label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => label == Service.others
          ? Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AllCategoriesColumn()))
          : Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServiceSearchScreen(
                    service: label,
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 4),
                          spreadRadius: 1,
                          blurRadius: 6)
                    ]),
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: Image.asset(icon),
                ),
              ),
            ),
            Text(label == Service.others ? 'All Services' : label.toString(),
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
