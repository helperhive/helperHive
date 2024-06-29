import 'package:flutter/material.dart';
import '../../backend/auth_methods.dart';
import 'package:helperhive/widgets/custum_auth_button.dart';
import 'signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;

  Future<void> _signIn() async {
    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Navigate to EditSettingsScreen (user_edit_settings.dart)
      Navigator.pushReplacementNamed(context, '/home_screen');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(height: 90),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email / Username',
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
                ),

                const SizedBox(height: 20),
                TextField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomAuthElevatedButton(
                    text: 'Log In',
                    color: Colors.orange.shade300,
                    onPressed: _signIn,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: TextButton(
                      onPressed: () {
                        // Implement your forgot password logic here
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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

                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    ).then((loginSuccessful) {
                      if (loginSuccessful == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Successfully done!'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please recheck and try again.'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text("Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
