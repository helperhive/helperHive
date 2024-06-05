import 'package:flutter/material.dart';
import 'package:helperhive/model/service_card_model.dart';
import 'package:helperhive/widgets/cards/service_card.dart';

class TopServicesList extends StatefulWidget {
  final int length;
  const TopServicesList({
    required this.length,
    super.key,
  });

  @override
  State<TopServicesList> createState() => _TopServicesListState();
}

class _TopServicesListState extends State<TopServicesList> {
  final List<ServicePersonData> servicePersons =
      ServicePersonData.servicePersons;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.length,
          itemBuilder: (context, index) {
            return ServiceCard(servicePersonData: servicePersons[index]);
          }),
    );
  }
}
