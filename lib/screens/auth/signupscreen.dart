import 'package:flutter/material.dart';
import 'package:helperhive/routes/app_routes.dart';
import '../../backend/auth_methods.dart';
import '../../model/user_model.dart';
import '../../widgets/custum_auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  Service _selectedService = Service.Cleaning;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          service: _selectedService,
        );
        Navigator.of(context).pushNamed(AppRoutes.loginRoute);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade400,
              Colors.blue.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  const Text(
                    "Let's Get Started!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Colors.blueGrey.shade200,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0), // Border color when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 2.0), // Border color when focused
                      ),
                      suffixIcon: const Icon(
                        IconData(0xe043,
                            fontFamily:
                                'MaterialIcons'), // Replace with your custom icon code point and fontFamily
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.blueGrey.shade200,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0), // Border color when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 2.0), // Border color when focused
                      ),
                      suffixIcon: const Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.blueGrey.shade200,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0), // Border color when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 2.0), // Border color when focused
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Please enter a password with at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      fillColor: Colors.blueGrey.shade200,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0), // Border color when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 2.0), // Border color when focused
                      ),
                      suffixIcon: const Icon(
                        IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: DropdownButton<Service>(
                          value: _selectedService,
                          isExpanded: true,
                          items: Service.values.map((service) {
                            return DropdownMenuItem<Service>(
                              value: service,
                              child: Text(service.toString().split('.').last),
                            );
                          }).toList(),
                          onChanged: (Service? newValue) {
                            setState(() {
                              _selectedService = newValue!;
                            });
                          }),
                    ),
                  ),

                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton<Service>(
                  //     value: _selectedService,
                  //     isExpanded: true,
                  //     items: Service.values.map((service) {
                  //       return DropdownMenuItem<Service>(
                  //         value: service,
                  //         child: Text(service.toString().split('.').last),
                  //       );
                  //     }).toList(),
                  //     onChanged: (Service? newValue) {
                  //       setState(() {
                  //         _selectedService = newValue!;
                  //       });
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: CustomAuthElevatedButton(
                            text: 'Sign Up',
                            color: Colors.orange.shade300,
                            onPressed: _signUp,
                          ),
                        ),

                  const SizedBox(height: 20),
                  Text('Or log in with',
                      style: TextStyle(color: Colors.blue.shade900)),
                  const SizedBox(height: 20),
                  //signin with google button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.cyan.shade800, // Border color
                            width: 2, // Border width
                          ),
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/logos/google_logo.jpg'), // Replace with your Google image asset
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Login With Google',
                              style: TextStyle(
                                color: Colors.cyan.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //signin with fb button
                  const SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.cyan.shade800, // Border color
                            width: 2, // Border width
                          ),
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/logos/fb_logo.jpg'), // Replace with your Google image asset
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Login With Facebook',
                              style: TextStyle(
                                color: Colors.cyan.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Log In",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
