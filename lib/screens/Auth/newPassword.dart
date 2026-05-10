import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'package:flutter/services.dart';

class NewPassword extends StatefulWidget {
  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: NgoPalette.navy,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please choose a strong, secure password that you haven\'t used before.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              
              _authField(
                controller: _password,
                label: 'New Password',
                hint: '••••••••',
                icon: Icons.lock_outline_rounded,
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
              _authField(
                controller: _confirmPassword,
                label: 'Confirm Password',
                hint: '••••••••',
                icon: Icons.lock_reset_rounded,
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
                    final password = _password.text;
                    final confirm = _confirmPassword.text;
                    final token = arguments['token'] as String;

                    if (password.isEmpty || confirm.isEmpty) {
                      await EasyLoading.showError('Please fill all fields');
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
                      await EasyLoading.show(status: 'Updating Password...');
                      final response = await Utils().resetPassword(
                        token,
                        password,
                        confirm,
                      );

                      if (response['status'] == false) {
                        await EasyLoading.showError(response['message']);
                      } else {
                        await EasyLoading.showSuccess('Password updated!');
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                      }
                    } catch (_) {
                      await EasyLoading.showError('Update failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NgoPalette.navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Save Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _authField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: NgoPalette.primary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            style: const TextStyle(fontWeight: FontWeight.w600, color: NgoPalette.ink),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
              prefixIcon: Icon(icon, color: NgoPalette.primary.withValues(alpha: 0.5), size: 20),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
          ),
        ),
      ],
    );
  }
}
