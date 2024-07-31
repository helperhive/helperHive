// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:helperhive/constants/color_them.dart';
import 'package:helperhive/enums/service_enum.dart';
import 'package:helperhive/screens/profile/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.user;
        final isUser = user.service == Service.user;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: blueColor,
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      provider.profileImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  MemoryImage(provider.profileImage!))
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(user.profileUrl)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              showImagePicker(context, provider);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildProfileForm(context, provider, isUser),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileForm(
      BuildContext context, UserProvider provider, bool isUser) {
    final nameController = TextEditingController(text: provider.user.name);
    final emailController = TextEditingController(text: provider.user.email);
    final phoneNumberController =
        TextEditingController(text: provider.user.phoneNumber);
    final locationController =
        TextEditingController(text: provider.user.location ?? 'Location');
    final descriptionController =
        TextEditingController(text: provider.user.description ?? 'Description');
    final experienceController = TextEditingController(
        text: provider.user.experience != 0
            ? provider.user.experience.toString()
            : 'Enter Experience');

    return Container(
      padding: const EdgeInsets.all(8.0),
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
            hintText: provider.user.location?.isEmpty ?? true
                ? 'Enter location'
                : provider.user.location!,
            leadingIcon: Icons.location_on,
          ),
          const SizedBox(height: 20),
          if (!isUser) ...[
            CustomTextField(
              controller: descriptionController,
              hintText: provider.user.description?.isEmpty ?? true
                  ? 'Enter description'
                  : provider.user.description!,
              leadingIcon: Icons.description,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: experienceController,
              hintText: provider.user.experience == 0
                  ? 'Enter experience'
                  : provider.user.experience.toString(),
              leadingIcon: Icons.work,
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: 180,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                String res = await provider.updateDetails(
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text,
                  profile: provider.profileUrl ?? provider.user.profileUrl,
                  location: locationController.text,
                  description: descriptionController.text,
                  experience: double.tryParse(experienceController.text),
                  connections: provider.user.connections,
                  service: provider.user.service,
                  price: provider.user.price,
                  rating: provider.user.rating,
                );
                if (res == 'update') {
                  showToast(context, 'Profile Updated Successfully');
                } else {
                  showToast(context, 'Retry again, profile not updated');
                }
              },
              child: provider.isUpdate
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : const Text(
                      'Update',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void showToast(BuildContext context, String message) {
    if (ScaffoldMessenger.maybeOf(context) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void showImagePicker(BuildContext context, UserProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Image',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    // color: Colors.blue,
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    provider.selectImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    // color: Colors.blue,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    provider.selectImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                // const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
