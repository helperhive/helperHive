import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/routes/app_routes.dart';
import 'package:helperhive/widgets/book_again_list.dart';
import 'package:helperhive/widgets/categories_column.dart';
import 'package:helperhive/widgets/discount_carousel.dart';
import 'package:helperhive/widgets/label_row.dart';
import 'package:helperhive/widgets/search_bar_home.dart';
import 'package:helperhive/widgets/top_services_list.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
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
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            const CategoriesColumn(),
            const SizedBox(
              height: 10,
            ),
            LabelRow(
              labelName: 'Top Services',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.searchScreenRoute);
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
              onTap: () {},
            ),
            const BookAgainList(),
            const SizedBox(
              height: 50,
            )
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
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&w=600"),
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
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: SearchBarHome(),
      ),
    );
  }
}
