import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/widgets/category_card.dart';
import 'package:helperhive/widgets/discount_card.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            _carousel(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: primaryColor),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                          icon: Icons.cleaning_services, label: 'Cleaning'),
                      CategoryCard(
                          icon: Icons.local_laundry_service, label: 'Washing'),
                      CategoryCard(
                          icon: Icons.build_circle_sharp, label: 'Repair'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                          icon: Icons.format_paint_outlined, label: 'Painting'),
                      CategoryCard(
                          icon: Icons.plumbing_outlined, label: 'Plumbing'),
                      CategoryCard(
                          icon: Icons.miscellaneous_services,
                          label: 'All Services'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlutterCarousel _carousel() {
    return FlutterCarousel(
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          height: 190,
          showIndicator: true,
          reverse: true,
          autoPlayCurve: Curves.easeInOut,
          slideIndicator: const CircularSlideIndicator(
              currentIndicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              indicatorRadius: 5),
        ),
        items: const [
          DiscountCard(
            service: 'Cleaning',
            code: 'CHEN356',
            discount: '40',
            imagePath: 'assets/cleaner.jpg',
          ),
          DiscountCard(
            service: 'Washing',
            code: 'WAHG856',
            discount: '20',
            imagePath: 'assets/washing.jpg',
          ),
          DiscountCard(
            service: 'Repair',
            code: 'REIR356',
            discount: '20',
            imagePath: 'assets/repair.jpg',
          ),
          DiscountCard(
            service: 'Painting',
            code: 'PATG294',
            discount: '20',
            imagePath: 'assets/painting.jpg',
          ),
          DiscountCard(
            service: 'Plumbing',
            code: 'PLBI356',
            discount: '25',
            imagePath: 'assets/plumber.jpg',
          ),
        ]);
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search for service...',
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              prefixIcon: const Icon(
                Icons.search,
                size: 26,
                color: primaryColor,
              ),
              suffixIcon: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.filter_alt_outlined,
                      size: 30, color: backgroundColor),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(117, 192, 223, 251),
              contentPadding: const EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}



// CategoryCard(
//                       icon: Icons.cleaning_services, label: 'Cleaning'),
//                   CategoryCard(
//                       icon: Icons.local_laundry_service, label: 'Washing'),
//                   CategoryCard(icon: Icons.build, label: 'Repair'),
//                   CategoryCard(icon: Icons.format_paint, label: 'Painting'),
//                   CategoryCard(icon: Icons.plumbing, label: 'Plumbing'),
//                   CategoryCard(
//                       icon: Icons.miscellaneous_services,
//                       label: 'All Services'),
