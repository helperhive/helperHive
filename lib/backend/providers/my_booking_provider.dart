// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MyBookingProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final User _user = FirebaseAuth.instance.currentUser!;

//   Stream<QuerySnapshot>? _myBookingStream;
//   Stream<QuerySnapshot> get myBookingStream => _myBookingStream!;
//   void getBookingsStream() {
//     _myBookingStream = _firestore
//         .collection('users')
//         .doc(_user.uid)
//         .collection('myBookings')
//         .snapshots();
//   }
// }
