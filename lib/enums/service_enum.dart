import 'package:flutter/material.dart';

enum Service {
  cleaning,
  washing,
  repair,
  painting,
  plumbing,
  healthcare,
  carpenter,
  movers,
  pestControl,
  saloon,
  electrician,
  beautyAndSpa,
  others,
  user;

  @override
  String toString() {
    return switch (this) {
      Service.cleaning => "Cleaning",
      Service.washing => "Washing",
      Service.repair => "Repair",
      Service.painting => "Painting",
      Service.plumbing => "Plumbing",
      Service.healthcare => "Healthcare",
      Service.carpenter => "Carpenter",
      Service.movers => "Movers",
      Service.pestControl => "Pest Control",
      Service.saloon => "Saloon",
      Service.electrician => "Electrical",
      Service.beautyAndSpa => "Beauty And Spa",
      Service.others => "Others",
      Service.user => "User",
    };
  }

  String toString2() {
    return switch (this) {
      Service.cleaning => "Cleaning",
      Service.washing => "Washing",
      Service.repair => "Repair",
      Service.painting => "Painting",
      Service.plumbing => "Plumbing",
      Service.healthcare => "Healthcare",
      Service.carpenter => "Carpenter",
      Service.movers => "Movers",
      Service.pestControl => "PestXpert",
      Service.saloon => "Saloon",
      Service.electrician => "Electrical",
      Service.beautyAndSpa => "Spa",
      Service.others => "Others",
      Service.user => "User",
    };
  }

  String toTitle() {
    return switch (this) {
      Service.cleaning => "Cleaning Service",
      Service.washing => "Washing Service",
      Service.repair => "Repair Service",
      Service.painting => "Painting Service",
      Service.plumbing => "Plumbing Service",
      Service.healthcare => "Healthcare Service",
      Service.carpenter => "Carpenter Service",
      Service.movers => "Movers Service",
      Service.pestControl => "Pest Control Service",
      Service.saloon => "Saloon Service",
      Service.electrician => "Electrical Service",
      Service.beautyAndSpa => "Beauty and Spa Service",
      Service.others => "Other Services",
      Service.user => 'User',
    };
  }

  String toService() {
    return switch (this) {
      Service.cleaning => "cleaner",
      Service.washing => "washer",
      Service.repair => "repair technician",
      Service.painting => "painter",
      Service.plumbing => "plumber",
      Service.healthcare => "healthcare provider",
      Service.carpenter => "carpenter",
      Service.movers => "mover",
      Service.pestControl => "pest control specialist",
      Service.saloon => "salon worker",
      Service.electrician => "electrician",
      Service.beautyAndSpa => "beauty and spa specialist",
      Service.others => "service provider",
      Service.user => "user",
    };
  }
}

IconData getIconForService(Service service) {
  switch (service) {
    case Service.cleaning:
      return Icons.cleaning_services;
    case Service.washing:
      return Icons.local_laundry_service;
    case Service.repair:
      return Icons.build;
    case Service.painting:
      return Icons.format_paint;
    case Service.plumbing:
      return Icons.plumbing;
    case Service.healthcare:
      return Icons.local_hospital;
    case Service.carpenter:
      return Icons.home;
    case Service.movers:
      return Icons.directions_car;
    case Service.pestControl:
      return Icons.bug_report;
    case Service.saloon:
      return Icons.content_cut;
    case Service.electrician:
      return Icons.local_dining;
    case Service.beautyAndSpa:
      return Icons.spa;
    case Service.others:
      return const IconData(0xf7f4, fontFamily: 'MaterialIcons');
    case Service.user:
      return Icons.account_circle_sharp;
    default:
      throw Exception('Unexpected service: $service');
  }
}

String getAssetForService(Service service) {
  switch (service) {
    case Service.cleaning:
      return 'assets/service_icons/cleaning.png';
    case Service.washing:
      return 'assets/service_icons/washing.png';
    case Service.repair:
      return 'assets/service_icons/repair.png';
    case Service.painting:
      return 'assets/service_icons/painter.png';
    case Service.plumbing:
      return 'assets/service_icons/plumbing.png';
    case Service.healthcare:
      return 'assets/service_icons/healthcare.png';
    case Service.carpenter:
      return 'assets/service_icons/carpenter.png';
    case Service.electrician:
      return 'assets/service_icons/electrician.png';
    case Service.pestControl:
      return 'assets/service_icons/pest_control.png';
    case Service.saloon:
      return 'assets/service_icons/saloon.png';
    case Service.movers:
      return 'assets/service_icons/movers.png';
    case Service.beautyAndSpa:
      return 'assets/service_icons/beauty_and_spa.png';
    case Service.others:
      return 'assets/service_icons/other.png';
    default:
      throw Exception('Unexpected service: $service');
  }
}
