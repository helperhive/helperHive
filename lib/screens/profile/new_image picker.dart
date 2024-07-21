import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _uploadImageToFirebase();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      // Get file name
      String fileName = path.basename(_image!.path);
      // Create a reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() => null);
      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();
      print('Download URL: $downloadURL');
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Update the 'imageUrl' field in the 'users' collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'imageUrl': downloadURL});
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.125,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/naruto.png') as ImageProvider,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 154, 239, 204),
                    border: Border.all(
                      color: Colors
                          .blue,
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    iconSize: 30.0,
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}