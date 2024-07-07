import 'package:flutter/material.dart';
import 'package:helperhive/widgets/cards/all_categories_card.dart';
import 'package:helperhive/constants/color_them.dart';

// remove this static info and make it to be dynamic and if possible retrive it from the data base
class AllCategoriesColumn extends StatefulWidget {
  const AllCategoriesColumn({super.key});

  @override
  State<AllCategoriesColumn> createState() => _AllCategoriesColumnState();
}

class _AllCategoriesColumnState extends State<AllCategoriesColumn> {
  final Map<String, IconData> categoryIcons = {
    'Cleaning': Icons.cleaning_services,
    'Washing': Icons.local_laundry_service,
    'Repairs': Icons.build,
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

  final Map<String, List<String>> categorySubcategories = {
    'Cleaning': [
      'House Cleaning',
      'Office Cleaning',
      'Window Cleaning',
      'Carpet Cleaning',
      'Deep Cleaning'
    ],
    'Washing': [
      'Laundry Service',
      'Dry Cleaning',
      'Vehicle Washing',
      'Carpet Cleaning'
    ],
    'Repairs': [
      'AC Repair',
      'Geyser Repair',
      'Washing Machine Repair',
      'Fridge Repair',
      ' Computer repairs'
    ],
    'Painting': [
      'Interior Painting',
      'Exterior Painting',
      'Commercial Painting',
      'Residential Painting',
      'Decorative painting '
    ],
    'Plumbing': [
      'Leak Repair',
      'Drain Cleaning',
      'Pipe Installation',
      'Water Heater Repair',
      'Bathroom Fittings',
      'Kitchen Plumbing'
    ],
    'Healthcare': [
      'General practitioner',
      'Home nursing',
      'Physical Therapy',
      'Mental health counselor'
    ],
    'Real Estate': [
      'Property buying',
      'Property selling',
      ' Rental Services',
      'Leasing'
    ],
    'Transportation': [
      'Vehical rentals',
      'Things/Luggage Delivery',
      'Public Transit'
    ],
    'Pest Control': [
      'Residential Pest Control',
      'Mosquito Control',
      'Termite Control',
      'Rodent Control'
    ],
    'Saloon': ['Haircut', 'Hair Coloring', 'Styling', 'Beard Grooming'],
    'Food and Beverage': [
      'Restaurant Management',
      'Catering',
      'Food Processing',
      'Beverage Production',
      'Personal Chef',
      'Cooking Classes'
    ],
    'Beauty and Spa': [
      'Skin Care',
      'Massage Therapy',
      'Hair Treatment',
      'Manicure and Pedicure',
      ' Makeup Services'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workers Profile Screen',
          style: TextStyle(fontSize: Checkbox.width),
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
                  final List<String> subcategories =
                      categorySubcategories[label] ?? [];

                  return CategoryCard(
                    icon: icon,
                    label: label,
                    subcategories: subcategories,
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

final Map<String, IconData> subcategoryIcons = {
  // Healthcare
  'General practitioner': Icons.medical_services,
  'Home nursing': Icons.home,
  'Physical Therapy': Icons.accessibility_new,
  'Mental health counselor': Icons.psychology,

  // Real Estate
  'Property buying': Icons.shopping_cart,
  'Property selling': Icons.sell,
  'Rental Services': Icons.apartment,
  'Leasing': Icons.assignment,

  // Transportation
  'Vehical rentals': Icons.car_rental,
  'Things/Luggage Delivery': Icons.local_shipping,
  'Public Transit': Icons.directions_bus,

  // Pest Control
  'Residential Pest Control': Icons.home,
  'Mosquito Control': Icons.bug_report,
  'Termite Control': Icons.verified,
  'Rodent Control': Icons.pest_control_rodent,

  // Saloon
  'Haircut': Icons.content_cut,
  'Hair Coloring': Icons.brush,
  'Styling': Icons.style,
  'Beard Grooming': Icons.face_retouching_natural,

  // Washing
  'Laundry Service': Icons.local_laundry_service,
  'Dry Cleaning': Icons.dry_cleaning,
  'Vehicle Washing': Icons.local_car_wash,
  'Carpet Cleaning': Icons.cleaning_services,

  // Repairs
  'AC Repair': Icons.ac_unit,
  'Geyser Repair': Icons.water,
  'Washing Machine Repair': Icons.local_laundry_service,
  'Fridge Repair': Icons.kitchen,
  'Computer repairs': Icons.computer,

  // Painting
  'Interior Painting': Icons.format_paint,
  'Exterior Painting': Icons.home,
  'Commercial Painting': Icons.business,
  'Residential Painting': Icons.house,
  'Decorative painting': Icons.color_lens,

  // Plumbing
  'Leak Repair': Icons.plumbing,
  'Drain Cleaning': Icons.cleaning_services,
  'Pipe Installation': Icons.build,
  'Water Heater Repair': Icons.water_damage,
  'Bathroom Fittings': Icons.bathtub,
  'Kitchen Plumbing': Icons.kitchen,

  // Cleaning
  'House Cleaning': Icons.home,
  'Office Cleaning': Icons.business,
  'Window Cleaning': Icons.window,
  //'Carpet Cleaning': Icons.sweep,
  'Deep Cleaning': Icons.clean_hands,

  // Food and Beverage
  'Restaurant Management': Icons.restaurant,
  'Catering': Icons.food_bank,
  'Food Processing': Icons.local_dining,
  'Beverage Production': Icons.local_bar,
  'Personal Chef': Icons.restaurant_menu,
  'Cooking Classes': Icons.school,

  // Beauty and Spa
  'Skin Care': Icons.spa,
  'Massage Therapy': Icons.self_improvement,
  'Hair Treatment': Icons.brush,
  'Manicure and Pedicure': Icons.content_cut,
  'Makeup Services': Icons.face,
};

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
            final subcategory = subcategories[index];
            final icon = subcategoryIcons[subcategory] ?? Icons.category;

            return ListTile(
              leading: Icon(icon),
              title: Text(subcategory),
              onTap: () {
                Navigator.pop(context, subcategory);
              },
            );
          },
        ),
      ),
    );
  }
}
