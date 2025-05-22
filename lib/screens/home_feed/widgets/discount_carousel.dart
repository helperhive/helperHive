import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';
import 'package:helperhive/widgets/cards/discount_card.dart';

class DiscountCarousel extends StatelessWidget {
  const DiscountCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: height * .27, // Match original carousel height
        child: Swiper(
          itemCount: 5, // Number of DiscountCard items
          itemBuilder: (context, index) {
            // List of DiscountCard items to maintain the same content
            final cards = [
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
            ];
            return cards[index];
          },
          autoplay: true, // Equivalent to autoPlay: true
          autoplayDelay: 3000, // Default delay in ms (adjust if needed)
          curve: Curves.easeInOut, // Match autoPlayCurve
          viewportFraction: 1.0, // Match viewportFraction: 1
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.blue, // Match currentIndicatorColor
              color: Colors.grey, // Match indicatorBackgroundColor
              size: 10.0, // Adjust size to match 5px radius (size is diameter)
              activeSize: 10.0, // Match active dot size
              space: 4.0, // Spacing between dots
            ),
          ),
        ),
      ),
    );
  }
}
