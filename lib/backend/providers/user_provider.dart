import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;
  UserModel get user => _user!;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchUser() async {
    // print('fetch user');
    _isLoading = true;
    try {
      var snap = await _firestore.collection('users').doc(uid).get();
      // print(snap.data());
      _user = UserModel.fromSnapshot(snap);
    } catch (e) {
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  List<ServiceBooking> _myBookings = [];
  List<ServiceBooking> get myBookigs => _myBookings;
  void getBookingsStream() {
    print('my bookings');
    _firestore
        .collection('users')
        .doc(uid)
        .collection('myBookings')
        .snapshots()
        .listen((snaps) {
      _myBookings =
          snaps.docs.map((snap) => ServiceBooking.fromSnapshot(snap)).toList();
      notifyListeners();
    });
  }
}
