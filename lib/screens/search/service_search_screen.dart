import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/service_person_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
// import 'package:helperhive/screens/search/widgets/service_providers.dart';
import 'package:helperhive/screens/search/widgets/category_filter_search.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'widgets/service_person_card.dart';

class ServiceSearchScreen extends StatelessWidget {
  final Service? service;
  const ServiceSearchScreen({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicePersonProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: primaryColor,
                size: 32,
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: SearchBarHome(
                onSearch: provider.onSearch,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: provider.isLosding
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CategoryFilter(
                      servicePersonProvider: provider,
                      selectedService: service,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: provider.serviceProviders.isEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Lottie.asset(
                                      'assets/not_found/no_user_found.json',
                                      height: 160,
                                      repeat: false,
                                    ),
                                    const Text(
                                      'Couldn\'t find matches.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        'Try searching for other providers or see recommendations',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
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
                                      servicePerson:
                                          provider.serviceProviders[index]);
                                },
                              ),
                      ),
                    )
                  ],
                ),
        ),
      );
    });
  }
}
