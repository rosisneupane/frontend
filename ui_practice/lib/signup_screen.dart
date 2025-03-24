import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ui_practice/config/config.dart';
import 'dart:convert';

import 'login_screen.dart';
import 'otp_verification_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    String url = AppConfig.apiUrl;
  final _formKey = GlobalKey<FormState>();
  String _username = '', _email = '', _password = '', _guardianEmail = '', _guardianPhone = '';
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      // Mock API call
      try {
        final response = await http.post(
          Uri.parse('$url/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'username': _username,
            'email': _email,
            'password': _password,
            'guardianEmail': _guardianEmail,
            'guardianPhone': _guardianPhone,
          }),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Sign Up Successful!", gravity: ToastGravity.BOTTOM);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OTPVerificationScreen(email: _guardianEmail)),
          );
        } else {
          Fluttertoast.showToast(msg: "Sign Up Failed. Try again.", gravity: ToastGravity.BOTTOM);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: $e", gravity: ToastGravity.BOTTOM);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  SizedBox(height: 20),

                  /// Username Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a username'
                        : null,
                    onSaved: (value) => _username = value!,
                  ),
                  SizedBox(height: 10),

                  /// Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => !value!.contains('@')
                        ? 'Please enter a valid email'
                        : null,
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 10),

                  /// Password Field
                  TextFormField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                    onSaved: (value) => _password = value!,
                  ),
                  SizedBox(height: 10),

                  /// Guardian Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Guardian’s Email',
                      prefixIcon: Icon(Icons.supervisor_account),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => !value!.contains('@')
                        ? 'Please enter a valid email'
                        : null,
                    onSaved: (value) => _guardianEmail = value!,
                  ),
                  SizedBox(height: 10),

                  /// Guardian Phone Field
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Guardian’s Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty || value.length < 10
                        ? 'Please enter a valid phone number'
                        : null,
                    onSaved: (value) => _guardianPhone = value!,
                  ),
                  SizedBox(height: 20),

                  /// Sign Up Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                    child: Text('Already have an account? Login'),
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
