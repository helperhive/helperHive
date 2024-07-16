import 'package:flutter/material.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/model/service_card_model.dart';

class ServiceCard extends StatelessWidget {
  final ServicePersonData servicePersonData;
  // final String imageUrl;
  // final String discount;
  // final String serviceName;
  // final String price;
  // final String providerName;
  // final double rating;

  const ServiceCard({
    super.key,
    required this.servicePersonData,
    // required this.imageUrl,
    // required this.discount,
    // required this.serviceName,
    // required this.price,
    // required this.providerName,
    // required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Container(
        // padding: EdgeInsets.all(value),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(31, 27, 27, 27),
                  offset: Offset(0, 4),
                  spreadRadius: 2,
                  blurRadius: 8)
            ]),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  servicePersonData.imageUrl,
                  width: 110,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${servicePersonData.discount}% discount",
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                servicePersonData.serviceName,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "${servicePersonData.price} \$ /hour ",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 24.0),
                              Text(
                                servicePersonData.rating.toString(),
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      // Text('By $providerName'),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: const TextStyle(color: primaryColor),
                                  children: [
                                const TextSpan(
                                  text: ' By  ',
                                ),
                                TextSpan(
                                    text: servicePersonData.providerName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              ])),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            Icons.work_outline,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${servicePersonData.experience.toString()} years',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
