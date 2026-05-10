import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isPasswordVisible = false;

  final _emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Ultra-premium Logo Section
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset('assets/images/nilesisters.png', fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: NgoPalette.navy,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sign in to continue to your community dashboard.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              
              // Minimalist Input Fields
              NgoTextField(
                controller: _email,
                label: 'Email Address',
                hint: 'name@example.com',
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                maxLength: 254,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny spaces
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
              
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/forgot_password'),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: NgoPalette.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _email.text.trim();
                    final password = _password.text;

                    if (email.isEmpty || password.isEmpty) {
                      await EasyLoading.showError('Please fill all fields');
                      return;
                    }

                    if (!_emailRegex.hasMatch(email)) {
                      await EasyLoading.showError('Invalid email format');
                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();
                    await EasyLoading.show(status: 'Authenticating...');
                    try {
                      final response = await Utils().login(email, password);
                      if (response['status'] == false) {
                        await EasyLoading.showError(response['message']);
                      } else {
                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString('token', response['token']);
                        await prefs.setInt('id', response['user']['id']);
                        await EasyLoading.showSuccess('Welcome back!');
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed('/home_page');
                        }
                      }
                    } catch (_) {
                      await EasyLoading.showError('Login failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NgoPalette.navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/signup'),
                    child: const Text(
                      'Create One',
                      style: TextStyle(
                        color: NgoPalette.navy,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
