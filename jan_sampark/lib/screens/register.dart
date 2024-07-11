import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _acceptedTerms = false;
  bool _acceptedPrivacyPolicy = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _voterIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();


  
  Future<void> _registerUser() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (!_acceptedTerms || !_acceptedPrivacyPolicy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please accept the terms and privacy policy')),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'aadhar': _aadhaarController.text,
        'phone': _phoneController.text,
        'pincode': _pincodeController.text,
        'voterId': _voterIdController.text,
      }),
    ).timeout(Duration(seconds: 10)); // Add a timeout

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')),
      );
      Navigator.pop(context); // Go back to login page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user: ${response.body}')),
      );
    }
  } catch (e) {
    print('Error during registration: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error during registration: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8E8EC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'Register yourself here!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildTextField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        icon: Icons.person,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        icon: Icons.person,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _aadhaarController,
                  labelText: 'Aadhaar Card Number',
                  icon: Icons.credit_card,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildTextField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        icon: Icons.phone,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: _pincodeController,
                        labelText: 'Pincode',
                        icon: Icons.location_pin,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _voterIdController,
                  labelText: 'Voter ID Number',
                  icon: Icons.how_to_vote,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Create your username and password',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _retypePasswordController,
                  labelText: 'Re-Type Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptedTerms = value!;
                        });
                      },
                    ),
                    const Text('I accept your '),
                    GestureDetector(
                      onTap: () {
                        // Handle Terms and Conditions tap
                      },
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _acceptedPrivacyPolicy,
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptedPrivacyPolicy = value!;
                        });
                      },
                    ),
                    const Text('I accept your '),
                    GestureDetector(
                      onTap: () {
                        // Handle Privacy Policy tap
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _acceptedTerms &&
                        _acceptedPrivacyPolicy) {
                      _registerUser();
                    } else {
                      // Show error message or handle form invalid state
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, size: 18),
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
