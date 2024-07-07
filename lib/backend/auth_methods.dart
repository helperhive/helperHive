import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
// import 'user_details.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user account
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required Service service,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // Create a new user document in Firestore
      await _firestore.collection('users').doc(user!.uid).set({ //use from and to json to send and receicve the data from the db
        'uid': user.uid,
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
        'service': service.toString().split('.').last,
        'location': '', // Ensure all fields are properly initialized
        'rating': 0.0,
        'experience': 0,
        'workingHours': {},
        'description': '',
        'imageUrl': '',
        'discount': 0.0,
        'price': 0.0,
      });
    } catch (e) {
      throw Exception('Failed to create user account: $e');
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Get the current user
  User? get currentUser => _auth.currentUser;

  // Get the user details from Firestore
  Future<UserModel> getUserDetails() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        } else {
          throw Exception('User document does not exist');
        }
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  // Update the user details in Firestore
  Future<void> updateUserDetails(UserModel userModel) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update(userModel.toMap());
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }

  // Update a specific field in the user document
  Future<void> updateUserDetailsField(
      String uid, Map<String, dynamic> updateData) async {
    try {
      await _firestore.collection('users').doc(uid).update(updateData);
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
