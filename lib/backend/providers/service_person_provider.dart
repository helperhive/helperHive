import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_person.dart';

class ServicePersonProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  ServicePerson? _servicePerson;
  ServicePerson get servicePerson => _servicePerson!;
  List<ServicePerson> _allServiceProviders = [];
  List<ServicePerson> _serviceProviders = [];
  List<ServicePerson> get serviceProviders => _serviceProviders;
  bool _isLoading = false;
  bool get isLosding => _isLoading;
  void fectchServiceProviders() {
    _isLoading = true;
    try {
      firestore
          .collection('workers')
          .snapshots(includeMetadataChanges: true)
          .listen((response) {
        _allServiceProviders = response.docs
            .map((doc) => ServicePerson.fromSnapshot(doc))
            .toList();
        _serviceProviders = _allServiceProviders;
        notifyListeners();
      });
      _isLoading = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> fetchServicePerson({String? userId}) async {
    _isLoading = true;
    String id = userId ?? uid;
    try {
      var snap = await firestore.collection('workers').doc(id).get();
      _servicePerson = ServicePerson.fromSnapshot(snap);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
    _isLoading = false;
  }

//we are using this search for searching the user by service only
  void onSearch(String? search) {
    if (search!.isEmpty) {
      _serviceProviders = _allServiceProviders;
    }

    _serviceProviders = _allServiceProviders
        .where((user) => (user.service
            .toString()
            .toLowerCase()
            .contains(search.toLowerCase())))
        .toList();

    //Try to implement this logic
    // if (selectedService == Service.others) {
    //   _serviceProviders = _allServiceProviders
    //       .where((user) => (user.service
    //           .toString()
    //           .toLowerCase()
    //           .contains(search.toLowerCase())))
    //       .toList();
    // } else {
    //   _serviceProviders = _allServiceProviders
    //       .where((user) => (selectedService
    //           .toString()
    //           .toLowerCase()
    //           .contains(search.toLowerCase())))
    //       .toList();
    // }

    notifyListeners();
  }

  Service _selectedService = Service.others;
  Service get selectedService => _selectedService;
  void onSelectservice(Service? service) {
    if (service == Service.others) {
      _serviceProviders = _allServiceProviders;
    } else {
      _serviceProviders = _allServiceProviders
          .where((user) => (user.service == service))
          .toList();
    }
    _selectedService = service ?? Service.others;
    notifyListeners();
  }
}
