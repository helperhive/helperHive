import 'package:flutter/material.dart';

enum Service {
  cleaning,
  washing,
  repairs,
  painting,
  plumbing,
  healthcare,
  realEstate,
  transportation,
  pestControl,
  saloon,
  foodAndBeverage,
  beautyAndSpa,
  others;

  @override
  String toString() {
    return switch (this) {
      Service.cleaning => "Cleaning",
      Service.washing => "Washing",
      Service.repairs => "Repairs",
      Service.painting => "Painting",
      Service.plumbing => "Plumbing",
      Service.healthcare => "Healthcare",
      Service.realEstate => "Real Estate",
      Service.transportation => "Transportation",
      Service.pestControl => "Pest Control",
      Service.saloon => "Saloon",
      Service.foodAndBeverage => "Food And Beverage",
      Service.beautyAndSpa => "Beauty And Spa",
      Service.others => "Others",
    };
  }

  String toTitle() {
    return switch (this) {
      Service.cleaning => "Cleaning Service",
      Service.washing => "Washing Service",
      Service.repairs => "Repair Service",
      Service.painting => "Painting Service",
      Service.plumbing => "Plumbing Service",
      Service.healthcare => "Healthcare Service",
      Service.realEstate => "Real Estate Service",
      Service.transportation => "Transportation Service",
      Service.pestControl => "Pest Control Service",
      Service.saloon => "Saloon Service",
      Service.foodAndBeverage => "Food and Beverage Service",
      Service.beautyAndSpa => "Beauty and Spa Service",
      Service.others => "Other Services",
    };
  }
}

IconData getIconForService(Service service) {
  switch (service) {
    case Service.cleaning:
      return Icons.cleaning_services;
    case Service.washing:
      return Icons.local_laundry_service;
    case Service.repairs:
      return Icons.build;
    case Service.painting:
      return Icons.format_paint;
    case Service.plumbing:
      return Icons.plumbing;
    case Service.healthcare:
      return Icons.local_hospital;
    case Service.realEstate:
      return Icons.home;
    case Service.transportation:
      return Icons.directions_car;
    case Service.pestControl:
      return Icons.bug_report;
    case Service.saloon:
      return Icons.content_cut;
    case Service.foodAndBeverage:
      return Icons.local_dining;
    case Service.beautyAndSpa:
      return Icons.spa;
    case Service.others:
      return const IconData(0xf7f4, fontFamily: 'MaterialIcons');
    default:
      throw Exception('Unexpected service: $service');
  }
}
