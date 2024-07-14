// import 'package:flutter/material.dart';

// import '../backend/auth_methods.dart';
// import '../model/user_model.dart';

// class EditSettingsScreen extends StatefulWidget {
//   const EditSettingsScreen({super.key});

//   @override
//   State<EditSettingsScreen> createState() => _EditSettingsScreenState();
// }

// class _EditSettingsScreenState extends State<EditSettingsScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _ratingController = TextEditingController();
//   final TextEditingController _experienceController = TextEditingController();
//   final TextEditingController _workingHoursController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _profileUrlController = TextEditingController();
//   final TextEditingController _discountController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final AuthService _authService = AuthService();
//   UserModel? _userModel;
//   bool _isLoading = false;
//   String _selectedService = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserDetails();
//   }

//   Future<void> _loadUserDetails() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       UserModel? userModel = await _authService.getUserDetails();
//       setState(() {
//         _userModel = userModel;
//         _nameController.text = userModel.name;
//         _selectedService = userModel.service.toString().split('.').last;
//         _locationController.text = userModel.location;
//         _ratingController.text = userModel.rating.toString();
//         _experienceController.text = userModel.experience.toString();
//         _workingHoursController.text = userModel.workingHours.toString();
//         _descriptionController.text = userModel.description;
//         _profileUrlController.text = userModel.profileUrl;
//         _discountController.text = userModel.discount.toString();
//         _priceController.text = userModel.price.toString();
//       });
//     } catch (e) {
//       print("Failed to load user details: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load user details: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _updateProfile() async {
//     setState(() {
//       _isLoading = true;
//     });
//     if (_userModel != null) {
//       UserModel updatedModel = UserModel(
//         uid: _userModel!.uid,
//         name: _nameController.text,
//         email: _userModel!.email,
//         phoneNumber: _userModel!.phoneNumber,
//         service: stringToService(_selectedService),
//         location: _locationController.text,
//         rating: double.tryParse(_ratingController.text) ?? 0.0,
//         experience: int.tryParse(_experienceController.text) ?? 0,
//         workingHours: Map<String, String>.from(_userModel!.workingHours),
//         description: _descriptionController.text,
//         profileUrl: _profileUrlController.text,
//         discount: double.tryParse(_discountController.text) ?? 0.0,
//         price: double.tryParse(_priceController.text) ?? 0.0,
//       );

//       try {
//         await _authService.updateUserDetails(updatedModel);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile updated successfully')),
//         );
//         // Reload user details after successful update
//         await _loadUserDetails();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Update failed: $e')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: _selectedService,
//                       items: Service.values.map((Service service) {
//                         return DropdownMenuItem<String>(
//                           value: service.toString().split('.').last,
//                           child: Text(service.toString().split('.').last),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedService = newValue!;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         labelText: 'Service',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _locationController,
//                       decoration: const InputDecoration(
//                         labelText: 'Location',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _ratingController,
//                       decoration: const InputDecoration(
//                         labelText: 'Rating',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _experienceController,
//                       decoration: const InputDecoration(
//                         labelText: 'Experience',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _workingHoursController,
//                       decoration: const InputDecoration(
//                         labelText: 'Working Hours',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _descriptionController,
//                       decoration: const InputDecoration(
//                         labelText: 'Description',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _profileUrlController,
//                       decoration: const InputDecoration(
//                         labelText: 'Image URL',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _discountController,
//                       decoration: const InputDecoration(
//                         labelText: 'Discount',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _priceController,
//                       decoration: const InputDecoration(
//                         labelText: 'Price',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: _updateProfile,
//                       child: const Text('Submit'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   // Helper function to convert string to Service enum
//   Service stringToService(String serviceString) {
//     return Service.values.firstWhere(
//         (e) => e.toString().split('.').last == serviceString,
//         orElse: () => Service.Others); // Default to an unknown service
//   }
// }
