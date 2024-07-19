import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/all_services/widgets/all_categories_card.dart';
import 'package:helperhive/screens/search/service_search_screen.dart';

class AllCategoriesColumn extends StatefulWidget {
  const AllCategoriesColumn({super.key});

  @override
  _AllCategoriesColumnState createState() => _AllCategoriesColumnState();
}

class _AllCategoriesColumnState extends State<AllCategoriesColumn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

                  final animationDelay =
                      (index / (Service.values.length - 2)) * 1.0;
                  final delayedAnimation = Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        animationDelay,
                        (animationDelay + 0.6)
                            .clamp(0.0, 1.0), // Ensure end is <= 1.0
                        curve: Curves.easeInOut,
                      ),
                    ),
                  );

                  return SlideTransition(
                    position: delayedAnimation,
                    child: AllCategoriesCard(
                      iconPath: iconPath,
                      label: service.toString2(),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ServiceSearchScreen(
                                  service: service,
                                )));
                      },
                    ),
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
