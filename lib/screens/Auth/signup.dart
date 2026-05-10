import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  final _phone = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  final _nameRegex = RegExp(r"^[a-zA-Z\s]{2,50}$");
  final _phoneRegex = RegExp(r"^\+?[0-9\s\-\(\)]{7,15}$");

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: NgoPalette.navy, size: 20),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: NgoPalette.navy,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Join our community and help make a difference.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              
              NgoTextField(
                controller: _name,
                label: 'Full Name',
                hint: 'John Doe',
                prefixIcon: Icons.person_outline_rounded,
                maxLength: 50,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
              ),
              const SizedBox(height: 20),
              NgoTextField(
                controller: _email,
                label: 'Email Address',
                hint: 'name@example.com',
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                maxLength: 254,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
              ),
              const SizedBox(height: 20),
              NgoTextField(
                controller: _phone,
                label: 'Phone Number',
                hint: '+1 (000) 000-0000',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                maxLength: 15,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\+\-\s\(\)]')),
                ],
              ),
              const SizedBox(height: 20),
              NgoTextField(
                controller: _password,
                label: 'Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: !_isPasswordVisible,
                maxLength: 128,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: NgoPalette.primary.withValues(alpha: 0.5),
                    size: 20,
                  ),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              const SizedBox(height: 20),
              NgoTextField(
                controller: _confirmpassword,
                label: 'Confirm Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_reset_rounded,
                obscureText: !_isConfirmPasswordVisible,
                maxLength: 128,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: NgoPalette.primary.withValues(alpha: 0.5),
                    size: 20,
                  ),
                  onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                ),
              ),
              
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = _name.text.trim();
                    final email = _email.text.trim();
                    final phone = _phone.text.trim();
                    final password = _password.text;
                    final confirm = _confirmpassword.text;

                    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirm.isEmpty) {
                      await EasyLoading.showError('Please fill all fields');
                      return;
                    }

                    if (!_nameRegex.hasMatch(name)) {
                      await EasyLoading.showError('Invalid name format');
                      return;
                    }

                    if (!_emailRegex.hasMatch(email)) {
                      await EasyLoading.showError('Invalid email format');
                      return;
                    }

                    if (!_phoneRegex.hasMatch(phone)) {
                      await EasyLoading.showError('Invalid phone number');
                      return;
                    }

                    if (password.length < 8) {
                      await EasyLoading.showError('Password min 8 characters');
                      return;
                    }

                    if (password != confirm) {
                      await EasyLoading.showError('Passwords do not match');
                      return;
                    }

                    try {
                      await EasyLoading.show(status: 'Creating Account...');
                      final response = await Utils().register(name, email, password, confirm, phone);

                      if (response['status'] == false) {
                        await EasyLoading.showError(response['message']);
                      } else {
                        await EasyLoading.showSuccess('Account created!');
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                      }
                    } catch (_) {
                      await EasyLoading.showError('Registration failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NgoPalette.navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(color: NgoPalette.navy, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
