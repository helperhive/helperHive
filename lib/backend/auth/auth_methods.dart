import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/user_model.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Signin using Email and Password
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required Service service,
  }) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      UserModel userModel = UserModel(
          uid: user!.uid,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          service: service,
          location: '',
          rating: 0.0,
          experience: 0,
          workingHours: {},
          description: '',
          profileUrl: '',
          discount: 0.0,
          price: 0.0,
          connections: []);
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
    } catch (e) {
      throw Exception('Failed to create user account: $e');
    }
  }

  //Signin using google
  Future<void> handlesigninWithGoogle(UserCredential userCredential) async {
    User? user = userCredential.user;

    if (user != null) {
      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // If the user does not exist, create a new user document
        await firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName,
          'phoneNumber': user.phoneNumber,
          'service': '',
          'location': '',
          'rating': 0.0,
          'experience': 0,
          'workingHours': {},
          'description': '',
          'imageUrl': '',
          'discount': 0.0,
          'price': 0.0,
          // 'createdAt': FieldValue.serverTimestamp(),
          // 'lastSignIn': FieldValue.serverTimestamp(),
        });
      } else {
        // If the user exists, update the last sign-in time
        await firestore.collection('users').doc(user.uid).update({
          'lastSignIn': FieldValue.serverTimestamp(),
        });
      }
    } else {
      throw Exception("User is null");
    }
  }

  // Login in with email and password
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Get the current user
  User? get currentUser => auth.currentUser;

  // Get the user details from Firestore
  Future<UserModel> getUserDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          return UserModel.fromSnapshot(snapshot);
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
      User? user = auth.currentUser;
      if (user != null) {
        await firestore
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
      await firestore.collection('users').doc(uid).update(updateData);
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
