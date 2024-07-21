import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/auth/auth_methods.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:helperhive/model/user_model.dart';
import 'package:helperhive/screens/auth/widgets/auth_button.dart';
import 'package:helperhive/screens/profile/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helperhive/constants/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isUpdating = false;
  bool isLoading = false;
  File? image;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController experienceController;
  late TextEditingController workingHoursController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    experienceController = TextEditingController();
    workingHoursController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    experienceController.dispose();
    workingHoursController.dispose();
    super.dispose();
  }

  
  Future<void> pickImage(ImageSource source) async {
    setState(() {
      isLoading = true;
    });

    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        isLoading = false;
      });

      // Upload image to Firebase and get the URL
      await uploadImageToFirebase();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> uploadImageToFirebase() async {
    if (image == null) return null;

    try {
      String fileName = path.basename(image!.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageReference.putFile(image!);
      await uploadTask.whenComplete(() => null);
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, _) {
      bool isUser = provider.user.service.toString() == "User";
      Future<void> updateDetails(String? imageUrl) async {
    setState(() {
      isUpdating = true;
    });

    final updatedUser = UserModel(
      uid: provider.user.uid,
      name: nameController.text.isEmpty ? provider.user.name : nameController.text,
      email: emailController.text.isEmpty ? provider.user.email : emailController.text,
      phoneNumber: phoneNumberController.text.isEmpty ? provider.user.phoneNumber : phoneNumberController.text,
      profileUrl: imageUrl ?? provider.user.profileUrl,
      location: locationController.text.isEmpty ? provider.user.location : locationController.text,
      description: descriptionController.text.isEmpty ? provider.user.description : descriptionController.text,
      experience: experienceController.text.isEmpty ? provider.user.experience : int.parse(experienceController.text),
      connections: provider.user.connections,
      service: provider.user.service,
      price: provider.user.price,
      rating : provider.user.rating,
      
      // workingHours: workingHoursController.text.isEmpty ? provider.user.workingHours : workingHoursController.text,
    );

      try {
        if (isUser) {
          await AuthService().updateUserDetails(updatedUser);
          
        } else {
          await AuthService().updateUserDetails(updatedUser);
          await AuthService().updateWorkerDetails(updatedUser);
        }
        // await AuthService().updateUserDetails(updatedUser);
        toastMessage(context: context, message: "User details updated");
      } catch (error) {
        toastMessage(context: context, message: error.toString());
      } finally {
        setState(() {
          isUpdating = false;
        });
      }
    }


      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: blueColor,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                                (provider.user.profileUrl == ''
                                    ? const CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage('assets/profile/profile.png'),
                                        backgroundColor: Colors.blueAccent,
                                      )
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(provider.user.profileUrl),
                                        backgroundColor: Colors.blueAccent,
                                      )),
                                
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () => pickImage(ImageSource.gallery),
                                  icon: isLoading
                                      ? const CircularProgressIndicator()
                                      : const Icon(Icons.edit, size: 10, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: nameController,
                                hintText: provider.user.name,
                                leadingIcon: Icons.person,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: emailController,
                                hintText: provider.user.email,
                                leadingIcon: Icons.email,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: phoneNumberController,
                                hintText: provider.user.phoneNumber,
                                leadingIcon: Icons.phone,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: locationController,
                                hintText: (provider.user.location.toString() == "") ? 'Enter location' : provider.user.location.toString(),
                                leadingIcon: Icons.location_on,
                              ),
                              const SizedBox(height: 20),
                              if (!isUser) ...[
                                CustomTextField(
                                  controller: descriptionController,
                                  hintText: (provider.user.description.toString() == "") ? 'Enter description' : provider.user.description.toString(),
                                  leadingIcon: Icons.description,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  controller: experienceController,
                                  hintText: (provider.user.experience.toString() == "0") ? 'Enter description' : provider.user.experience.toString(),
                                  leadingIcon: Icons.work,
                                ),
                                // const SizedBox(height: 20),
                                // CustomTextField(
                                //   controller: workingHoursController,
                                //   hintText: provider.user.workingHours.toString(),
                                //   leadingIcon: Icons.schedule,
                                // ),
                              ],
                              const SizedBox(height: 32),
                              AuthButton(
                                onTap: () async {
                                  String? imageUrl = await uploadImageToFirebase();
                                  await updateDetails(imageUrl);
                                },
                                text: 'Update',
                                backgroundcolor: Colors.blue.shade300,
                                textColor: Colors.black,
                                isloading: isUpdating,
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
