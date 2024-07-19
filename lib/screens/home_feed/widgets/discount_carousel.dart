import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:helperhive/widgets/cards/discount_card.dart';

class DiscountCarousel extends StatelessWidget {
  const DiscountCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FlutterCarousel(
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          height: 195,
          showIndicator: true,
          reverse: true,
          autoPlayCurve: Curves.easeInOut,
          slideIndicator: const CircularSlideIndicator(
              currentIndicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              indicatorRadius: 5),
        ),
        items: [
          DiscountCard(
            service: 'Cleaning',
            code: 'CHEN356',
            discount: '40',
            imagePath: 'assets/discount_arousel_images/cleaner.jpg',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen(
                      service: Service.cleaning,
                    ))),
          ),
          DiscountCard(
            service: 'Washing',
            code: 'WAHG856',
            discount: '20',
            imagePath: 'assets/discount_arousel_images/washing.jpg',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen(
                      service: Service.washing,
                    ))),
          ),
          DiscountCard(
            service: 'Repair',
            code: 'REIR356',
            discount: '20',
            imagePath: 'assets/discount_arousel_images/repair.jpg',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen(
                      service: Service.repair,
                    ))),
          ),
          DiscountCard(
            service: 'Painting',
            code: 'PATG294',
            discount: '20',
            imagePath: 'assets/discount_arousel_images/painting.jpg',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen(
                      service: Service.painting,
                    ))),
          ),
          DiscountCard(
            service: 'Plumbing',
            code: 'PLBI356',
            discount: '25',
            imagePath: 'assets/discount_arousel_images/plumber.jpg',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ServiceSearchScreen(
                      service: Service.plumbing,
                    ))),
          ),
        ],
      ),
    );
  }
}
