import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_categories_screen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/widgets/list_builders/book_again_list.dart';
import 'package:helperhive/widgets/categories_column.dart';
import 'package:helperhive/widgets/list_builders/discount_carousel.dart';
import 'package:helperhive/widgets/label_row.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:helperhive/widgets/list_builders/swiper_builder.dart';
import 'package:helperhive/widgets/list_builders/top_services_list.dart';
import 'package:helperhive/screens/booking/booking_details_screen.dart';
// import 'package:helperhive/screens/booking/widgets/service_providers.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void onSearch(String value) {}
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _homeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            const DiscountCarousel(),
            const SizedBox(
              height: 5,
            ),
            LabelRow(
              labelName: "Categories",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const AllCategoriesColumn())));
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const CategoriesRow(),
            const SizedBox(
              height: 10,
            ),
            LabelRow(
                labelName: 'My Bookings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingScreen(),
                    ),
                  );
                }),
            SwiperBuilder(),
            LabelRow(
              labelName: 'Top Services',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceSearchScreen()));
              },
            ),
            const TopServicesList(
              length: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            LabelRow(
              labelName: "Book Again",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceSearchScreen()));
              },
            ),
            const BookAgainList(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 65,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/logos/helperHive.png'),
            ),
            title: Text(
              'Narasimha Naidu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  'Bhimavaram',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.expand_more)
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: primaryColor,
            size: 32,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SearchBarHome(
          onSearch: onSearch,
        ),
      ),
    );
  }
}
