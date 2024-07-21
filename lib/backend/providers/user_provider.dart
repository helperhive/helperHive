// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:helperhive/backend/storage/firebase_storage.dart';
// import 'package:helperhive/constants/image_picker.dart';
// import 'package:helperhive/model/service_booking.dart';
// import 'package:helperhive/model/user_model.dart';
// import 'package:image_picker/image_picker.dart';

// class UserProvider extends ChangeNotifier {
//   final String uid = FirebaseAuth.instance.currentUser!.uid;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   UserModel? _user;
//   UserModel get user => _user!;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   Future<void> fetchUser() async {
//     // print('fetch user');
//     _isLoading = true;
//     try {
//       var snap = await _firestore.collection('users').doc(uid).get();
//       // print(snap.data());
//       _user = UserModel.fromSnapshot(snap);
//     } catch (e) {
//       print(e.toString());
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   List<ServiceBooking> _myBookings = [];
//   List<ServiceBooking> get myBookigs => _myBookings;
//   void getBookingsStream() {
//     _firestore
//         .collection('users')
//         .doc(uid)
//         .collection('myBookings')
//         .snapshots()
//         .listen((snaps) {
//       _myBookings =
//           snaps.docs.map((snap) => ServiceBooking.fromSnapshot(snap)).toList();
//       notifyListeners();
//     });
//   }

//   Uint8List? _profileImage;
//   Uint8List? get profileImage => _profileImage;
//   void selectImage(ImageSource source) async {
//     Uint8List image = await pickImage(source);
//     _profileImage = image;
//     // print(profileImage);
//     notifyListeners();
//   }

//   String? _profileUrl;
//   String? get profileUrl => _profileUrl;

//   Future<void> generateProfileUrl() async {
//     try {
//       _profileUrl = await StorageMethods.uploadImageToStorage(
//         childName: 'profile',
//         file: profileImage!,
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/storage/firebase_storage.dart';
import 'package:helperhive/constants/image_picker.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/service_booking.dart';
import 'package:helperhive/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;
  UserModel get user => _user!;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchUser() async {
    _isLoading = true;
    try {
      var snap = await _firestore.collection('users').doc(uid).get();
      _user = UserModel.fromSnapshot(snap);
    } catch (e) {
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  List<ServiceBooking> _myBookings = [];
  List<ServiceBooking> get myBookings => _myBookings;

  void getBookingsStream() {
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

  Uint8List? _profileImage;
  Uint8List? get profileImage => _profileImage;

  void selectImage(ImageSource source) async {
    Uint8List image = await pickImage(source);
    _profileImage = image;
    if (image.isNotEmpty) {
      generateProfileUrl();
    }
    notifyListeners();
  }

  String? _profileUrl;
  String? get profileUrl => _profileUrl;

  Future<void> generateProfileUrl() async {
    try {
      _profileUrl = await StorageMethods.uploadImageToStorage(
        childName: 'profile',
        file: profileImage!,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;
  Future<String> updateDetails({
    required String name,
    required String email,
    required String phoneNumber,
    String? profile,
    String? location,
    String? description,
    double? experience,
    List<dynamic>? connections,
    Service? service,
    double? price,
    double? rating,
  }) async {
    String res = '';
    final updatedUser = UserModel(
      uid: uid,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileUrl: profile!,
      location: location,
      description: description,
      experience: experience,
      connections: connections!,
      service: service,
      price: price,
      rating: rating,
    );

    try {
      _isUpdate = true;
      notifyListeners();
      if (service == Service.user) {
        await _firestore
            .collection('users')
            .doc(uid)
            .update(updatedUser.toMap());
      } else {
        await _firestore
            .collection('users')
            .doc(uid)
            .update(updatedUser.toMap());
        await _firestore
            .collection('workers')
            .doc(uid)
            .update(updatedUser.toMap());
      }
      _isUpdate = false;
      res = 'update';
      fetchUser();
      notifyListeners();
    } catch (error) {
      res = error.toString();
      throw Exception(error.toString());
    }
    return res;
  }
}
