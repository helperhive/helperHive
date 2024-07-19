// import 'package:flutter/material.dart';
// import 'package:helperhive/backend/providers/service_person_provider.dart';
// import 'package:helperhive/constants/color_them.dart';
// import 'package:helperhive/enums/service_enum.dart';
// import 'package:helperhive/model/service_card_model.dart';
// import 'package:helperhive/model/service_person.dart';
// import 'package:helperhive/screens/booking/workers_profile_screen.dart';
// import 'package:provider/provider.dart';

// class ServiceProviders extends StatefulWidget {
//   final String? selectedCategory;
//   final String searchQuery;

//   const ServiceProviders({
//     super.key,
//     this.selectedCategory,
//     required this.searchQuery,
//   });

//   @override
//   State<ServiceProviders> createState() => ServiceProvidersState();
// }

// class ServiceProvidersState extends State<ServiceProviders> {
//   final List<ServicePersonData> servicePersons =
//       ServicePersonData.servicePersons;

//   @override
//   Widget build(BuildContext context) {

//     return Consumer<ServicePersonProvider>(builder: (context, provider, _) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: provider.isLosding
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : ListView.separated(
//                 padding: const EdgeInsets.only(top: 16),
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(
//                     height: 16,
//                   );
//                 },
//                 itemCount: provider.serviceProviders.length,
//                 itemBuilder: (context, index) {
//                   return ServicePersonCard(
//                       servicePerson: provider.serviceProviders[index]);
//                 },
//               ),
//       );
//     });
//   }
// }

