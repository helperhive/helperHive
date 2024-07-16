import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/model/user_model.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Signin using Email and Password for workers
  Future<String> signUpWithEmailAndPasswordforWorkers({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    Service? service,
  }) async {
    String res = '';
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      UserModel userModel = UserModel(
          uid: user!.uid,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          service: service ?? Service.others,
          location: '',
          rating: 0.0,
          experience: 0,
          workingHours: {},
          description: '',
          profileUrl: '',
          // discount: 0.0,
          price: 0.0,
          connections: []);
      await firestore
          .collection('workers')
          .doc(user.uid)
          .set(userModel.toMap());
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (e.code == "invalid-email") {
        res = "Email is Badly Formated";
      } else {
        res = e.message.toString();
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Signin using Email and Password for Users
  Future<String> signUpWithEmailAndPasswordforUsers({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String location,
  }) async {
    String res = '';
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      UserModel userModel = UserModel(
          uid: user!.uid,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          location: location,
          profileUrl: '',
          service: Service.user,
          connections: []);
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (e.code == "invalid-email") {
        res = "Email is Badly Formated";
      } else {
        res = e.message.toString();
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Signin using google for workers
  Future<void> handlesigninWithGoogleforWorkers(
      UserCredential userCredential) async {
    User? user = userCredential.user;

    if (user != null) {
      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc =
          await firestore.collection('workers').doc(user.uid).get();

      if (!userDoc.exists) {
        // If the user does not exist, create a new user document
        UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email!,
            name: "",
            phoneNumber: user.phoneNumber!,
            service: Service.others,
            location: '',
            rating: 0.0,
            experience: 0,
            workingHours: {},
            description: '',
            profileUrl: '',
            // discount: 0.0,
            price: 0.0,
            connections: []);
        await firestore
            .collection('workers')
            .doc(user.uid)
            .set(userModel.toMap());
      } else {
        // If the user exists, update the last sign-in time
        await firestore.collection('workers').doc(user.uid).update({
          'lastSignIn': FieldValue.serverTimestamp(),
        });
      }
    } else {
      throw Exception("Worker is null");
    }
  }

  //Signin using google for users
  Future<void> handlesigninWithGoogleforUsers(
      UserCredential userCredential) async {
    User? user = userCredential.user;

    if (user != null) {
      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // If the user does not exist, create a new user document
        UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email!,
            name: "",
            phoneNumber: user.phoneNumber!,
            profileUrl: '',
            service: Service.user,
            connections: []);
        await firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
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
  Future<String> logInWithEmailAndPassword(
      String email, String password) async {
    String res = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        res = 'Invalid Password ';
      } else if (e.message.toString() ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        res = "Invalid credential";
      } else {
        res = e.message.toString();
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
    return res;
  }

// Reset Password

  Future<String> resetPassword(String email) async {
    String res = '';
    try {
      await auth.sendPasswordResetEmail(email: email);
      res = 'Password Reset Email Sent to $email';
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Get the current  worker
  User? get currentUser => auth.currentUser;

  // Get the worker details from Firestore
  Future<UserModel> getWorkerDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('workers').doc(user.uid).get();
        if (snapshot.exists) {
          return UserModel.fromSnapshot(snapshot);
        } else {
          throw Exception('Worker document does not exist');
        }
      } else {
        throw Exception('Worker not found');
      }
    } catch (e) {
      throw Exception('Failed to get Worker details: $e');
    }
  }

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
      throw Exception('Failed to get User details: $e');
    }
  }

// Update the worker details in Firestore
  Future<void> updateWorkerDetails(UserModel userModel) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('workers')
            .doc(user.uid)
            .update(userModel.toMap());
      } else {
        throw Exception('Worker not found');
      }
    } catch (e) {
      throw Exception('Failed to update Worker details: $e');
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
  Future<void> updateWorkerDetailsField(
      String uid, Map<String, dynamic> updateData) async {
    try {
      await firestore.collection('workers').doc(uid).update(updateData);
    } catch (e) {
      throw Exception('Failed to update Worker details: $e');
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
  Future<void> signOutUser() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
