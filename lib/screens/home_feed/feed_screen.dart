import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/screens/all_categories_screen.dart';
import 'package:helperhive/screens/service_search_screen.dart';
import 'package:helperhive/screens/home_feed/widgets/book_again_list.dart';
import 'package:helperhive/screens/home_feed/widgets/categories_column.dart';
import 'package:helperhive/screens/home_feed/widgets/discount_carousel.dart';
import 'package:helperhive/screens/home_feed/widgets/label_row.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:helperhive/screens/home_feed/widgets/swiper_builder.dart';
import 'package:helperhive/screens/home_feed/widgets/top_services_list.dart';
import 'package:helperhive/screens/booking/booking_details_screen.dart';
// import 'package:helperhive/screens/booking/widgets/service_providers.dart';

//need to make this feed screen dynamic
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
          suffixIcon: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.filter_alt_outlined,
                  size: 30, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
