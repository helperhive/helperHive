import 'package:flutter/material.dart';
import '../../backend/auth_methods.dart';
import 'package:helperhive/widgets/custum_auth_button.dart';
import 'signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email / Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomAuthElevatedButton(
                  text: 'Log In',
                  color: Colors.blue,
                  onPressed: _signIn,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Implement your forgot password logic here
                },
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: 20),
              const Text('Or log in with'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomAuthElevatedButton(
                  text: 'LOGIN WITH GOOGLE',
                  icon: Icons.g_mobiledata_outlined,
                  color: Colors.red.shade300,
                  onPressed: () {
                    // Implement Google login logic here
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomAuthElevatedButton(
                  text: 'LOGIN WITH FACEBOOK',
                  icon: Icons.facebook,
                  color: Colors.blue.shade200,
                  onPressed: () {
                    // Implement Facebook login logic here
                  },
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
                        SnackBar(
                          content: Text('Successfully done!'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please recheck and try again.'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  });
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
