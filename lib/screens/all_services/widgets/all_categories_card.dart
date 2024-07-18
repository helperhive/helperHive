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

// import 'package:flutter/material.dart';

// class AllCategoriesCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   // final List<String> subcategories;
//   final Function()? onTap;

//   const AllCategoriesCard(
//       {super.key,
//       required this.icon,
//       required this.label,
//       // required this.subcategories,

//       this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap ?? () {},
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
  final String iconPath;
  final String label;
  final Function()? onTap;

  const AllCategoriesCard(
      {super.key, required this.iconPath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      splashColor: Colors.blue.shade300,
      child: Column(
        children: [
          Container(
            width: 110,
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 2),
                  ),
                ]),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
