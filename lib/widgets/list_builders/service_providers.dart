import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_card_model.dart';
import 'package:helperhive/screens/profile/workers_profile_screen.dart';

class ServiceProviders extends StatefulWidget {
  final String selectedCategory;
  final String searchQuery;

  const ServiceProviders({
    super.key,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  State<ServiceProviders> createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  final List<ServicePersonData> servicePersons =
      ServicePersonData.servicePersons;

  @override
  Widget build(BuildContext context) {
    List<ServicePersonData> filteredSpecialists = servicePersons
        .where((specialist) =>
            (widget.selectedCategory == 'All' ||
                specialist.serviceName == widget.selectedCategory) &&
            specialist.providerName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSpecialists.length,
      itemBuilder: (context, index) {
        return ServicePersonCard(servicePerson: filteredSpecialists[index]);
      },
    );
  }
}

class ServicePersonCard extends StatelessWidget {
  final ServicePersonData servicePerson;

  const ServicePersonCard({super.key, required this.servicePerson});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        // padding: const EdgeInsets.all(10.0),
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              servicePerson.imageUrl,
              width: 80,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicePerson.providerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(servicePerson.serviceName),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        const SizedBox(width: 2.0),
                        Text('${servicePerson.rating}'),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.work_outline,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '${servicePerson.experience} Years',
                          style: const TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WorkersProfileScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Book Now'),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }
}
