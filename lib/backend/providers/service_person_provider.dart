import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/model/service_person.dart';

class ServicePersonProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  ServicePerson? _servicePerson;
  ServicePerson get servicePerson => _servicePerson!;

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
        _serviceProviders = response.docs
            .map((doc) => ServicePerson.fromSnapshot(doc))
            .toList();
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
}
