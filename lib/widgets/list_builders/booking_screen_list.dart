import 'package:flutter/material.dart';
import 'package:helperhive/model/service_card_model.dart';
import 'package:helperhive/widgets/list_builders/service_providers.dart';

class FilteredBookings extends StatelessWidget {
  final List<ServicePersonData> servicePersons =
      ServicePersonData.servicePersons;
  final String selectedCategory;
  final String searchQuery;

  FilteredBookings({
    super.key,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    List<ServicePersonData> filteredSpecialists = servicePersons
        .where((servicePerson) =>
            (selectedCategory == 'Bookings' ||
                servicePerson.choice == selectedCategory) &&
            (searchQuery.isEmpty ||
                servicePerson.choice!
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())))
        .toList();

    return ListView.builder(
      itemCount: filteredSpecialists.length,
      itemBuilder: (context, index) {
        return ServicePersonCard(servicePerson: filteredSpecialists[index]);
      },
    );
  }
}
