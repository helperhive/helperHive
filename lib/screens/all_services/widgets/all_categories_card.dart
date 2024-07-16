// import 'package:flutter/material.dart';

// class CategoryCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap; // Add onTap parameter

//   const CategoryCard({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onTap, // Add onTap to constructor
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap, // Use onTap here
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.blue, // Background color
//               borderRadius: BorderRadius.circular(15), // Border radius
//             ),
//             padding: const EdgeInsets.all(
//                 10), // Padding to adjust the icon within the container
//             child: Icon(icon,
//                 size: 25, color: Colors.white), // Icon with white color
//           ),
//           const SizedBox(height: 5),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AllCategoriesCard extends StatelessWidget {
  final IconData icon;
  final String label;
  // final List<String> subcategories;
  final Function()? onTap;

  const AllCategoriesCard(
      {super.key,
      required this.icon,
      required this.label,
      // required this.subcategories,

      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Background color
              borderRadius: BorderRadius.circular(15), // Border radius
            ),
            padding: const EdgeInsets.all(
                10), // Padding to adjust the icon within the container
            child: Icon(icon,
                size: 25, color: Colors.white), // Icon with white color
          ),
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
