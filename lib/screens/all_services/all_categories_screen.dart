import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/all_services/widgets/all_categories_card.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';

class AllCategoriesColumn extends StatelessWidget {
  const AllCategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount:
                    Service.values.length - 2, // Excluding the 'user' service
                itemBuilder: (context, index) {
                  Service service = Service.values[index];
                  String iconPath = getAssetForService(service);

                  return AllCategoriesCard(
                    iconPath: iconPath,
                    label: service.toString2(),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ServiceSearchScreen(
                                service: service,
                              )));
                    },
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
