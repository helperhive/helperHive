import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/service_person_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_card_model.dart';
import 'package:helperhive/model/service_person.dart';
import 'package:helperhive/screens/booking/workers_profile_screen.dart';
import 'package:provider/provider.dart';

class ServiceProviders extends StatefulWidget {
  final String? selectedCategory;
  final String searchQuery;

  const ServiceProviders({
    super.key,
    this.selectedCategory,
    required this.searchQuery,
  });

  @override
  State<ServiceProviders> createState() => ServiceProvidersState();
}

class ServiceProvidersState extends State<ServiceProviders> {
  final List<ServicePersonData> servicePersons =
      ServicePersonData.servicePersons;

  @override
  Widget build(BuildContext context) {
    // List<ServicePersonData> filteredSpecialists = servicePersons
    //     .where((specialist) =>
    //         (widget.selectedCategory == 'All' ||
    //             specialist.serviceName == widget.selectedCategory) &&
    //         specialist.providerName
    //             .toLowerCase()
    //             .contains(widget.searchQuery.toLowerCase()))
    //     .toList();

    return Consumer<ServicePersonProvider>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: provider.isLosding
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: provider.serviceProviders.length,
                itemBuilder: (context, index) {
                  return ServicePersonCard(
                      servicePerson: provider.serviceProviders[index]);
                },
              ),
      );
    });
  }
}

class ServicePersonCard extends StatelessWidget {
  final ServicePerson servicePerson;

  const ServicePersonCard({super.key, required this.servicePerson});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                spreadRadius: 2,
                blurRadius: 8,
                color: Colors.grey.shade300)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 65,
              height: 50,
              child: Image(
                image: AssetImage(
                  getAssetForService(servicePerson.service),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servicePerson.service.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    servicePerson.name,
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    ' Rs ${servicePerson.price}/hr ',
                    style: const TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 2.0),
                      Text(
                        '${servicePerson.rating} Rating',
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
                  builder: (context) => WorkersProfileScreen(
                        servicePerson: servicePerson,
                      )));
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
    );
  }
}
