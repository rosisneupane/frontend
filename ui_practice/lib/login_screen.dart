import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_practice/config/config.dart';
import 'signup_screen.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String url = AppConfig.apiUrl;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _email = '', _password = '';

  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //   }
  // }

Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$url/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _email,
          'password': _password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['access_token'] != null) {
          // Save token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', responseData['access_token']);

          Fluttertoast.showToast(
              msg: "Login Successful!", gravity: ToastGravity.BOTTOM);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (responseData['detail'] != null) {
          // Case when user is not verified
          Fluttertoast.showToast(
              msg: responseData['detail'], gravity: ToastGravity.BOTTOM);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed. Try again.", gravity: ToastGravity.BOTTOM);
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
                  Text('Welcome Back!',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple)),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        !value!.contains('@') ? 'Invalid email' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Password cannot be empty' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
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
                        : Text('Login'),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                    child: Text('Sign up'),
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
