import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/workers_profile_screen.dart';

class SpecialistList extends StatelessWidget {
  final List<Specialist> specialists = [
    Specialist(
      name: 'Prakash',
      specialty: 'Electrician',
      choice: 'Bookings',
      rating: 4.5,
      years: 3,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Specialist(
      name: 'Vishnu',
      specialty: 'Electrician',
      choice: 'Previous Bookings',
      rating: 4.0,
      years: 3,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  final String selectedCategory;
  final String searchQuery;

  SpecialistList({
    super.key,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    List<Specialist> filteredSpecialists = specialists
        .where((specialist) =>
            (selectedCategory == 'Bookings' ||
                specialist.choice == selectedCategory) &&
            specialist.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSpecialists.length,
      itemBuilder: (context, index) {
        return SpecialistCard(
          specialist: filteredSpecialists[index],
          selectedCategory: selectedCategory,
        );
      },
    );
  }
}

class Specialist {
  final String name;
  final String specialty;
  final String choice;
  final double rating;
  final int years;
  final String imageUrl;

  Specialist({
    required this.name,
    required this.specialty,
    required this.choice,
    required this.rating,
    required this.years,
    required this.imageUrl,
  });
}

class SpecialistCard extends StatelessWidget {
  final Specialist specialist;
  final String selectedCategory;

  const SpecialistCard({
    super.key,
    required this.specialist,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    String buttonText =
        selectedCategory == 'Previous Bookings' ? 'Booked' : 'Book Now';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(specialist.imageUrl),
        ),
        title: Text(specialist.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialist.specialty),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 4.0),
                Text('${specialist.rating}'),
                const SizedBox(width: 8.0),
                const Icon(Icons.work, size: 16),
                const SizedBox(width: 4.0),
                Text('${specialist.years} Years'),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WorkersProfileScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: blueColor,
            foregroundColor: secondaryColor,
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
