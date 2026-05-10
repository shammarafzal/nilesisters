import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';

class VerifyToken extends StatefulWidget {
  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  void dispose() {
    _controller.dispose();
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify Token',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: NgoPalette.navy,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please enter the 4-digit verification code sent to your email.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 60),
              
              Center(
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: NgoPalette.navy,
                      letterSpacing: 24,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '0000',
                      hintStyle: TextStyle(color: Color(0xFFE5E5EA), letterSpacing: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_controller.text.length < 4) {
                      await EasyLoading.showError('Please enter the 4-digit code');
                      return;
                    }
                    await EasyLoading.show(status: 'Verifying...');
                    try {
                      final response = await Utils().checkForgotToken(_controller.text);
                      if (response['status'] == false) {
                        await EasyLoading.showError(response['message']);
                      } else {
                        await EasyLoading.showSuccess('Token verified');
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed(
                            '/new_password',
                            arguments: {'token': _controller.text},
                          );
                        }
                      }
                    } catch (_) {
                      await EasyLoading.showError('Verification failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NgoPalette.navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Verify Code',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                      color: NgoPalette.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: NgoPalette.heroGradient,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Text(
        'Token verification',
        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
      ),
    );
  }
}
