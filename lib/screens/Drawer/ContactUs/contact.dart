import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'package:flutter/services.dart';

class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  final _emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NgoPageShell(
      title: 'Contact Us',
      subtitle: 'We are here to help and answer any questions.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: NgoPalette.ink,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Whether you have a question about services, volunteering, or anything else, our team is ready to listen.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF8E8E93),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          
          // Contact Info Tiles
          Row(
            children: [
              _infoTile(Icons.mail_rounded, 'Email', 'info@nilesisters.org'),
              const SizedBox(width: 12),
              _infoTile(Icons.phone_rounded, 'Call', '+1 (619) 582-2040'),
            ],
          ),
          const SizedBox(height: 12),
          _infoTile(Icons.location_on_rounded, 'Office', '8322 Clairemont Mesa Blvd, San Diego, CA'),
          
          const SizedBox(height: 40),
          const Text(
            'Send a Message',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: NgoPalette.ink),
          ),
          const SizedBox(height: 20),
          
          _customField(
            controller: _name,
            hint: 'Full Name',
            icon: Icons.person_outline_rounded,
            maxLength: 50,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            ],
          ),
          const SizedBox(height: 16),
          _customField(
            controller: _email,
            hint: 'Email Address',
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            maxLength: 254,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
          ),
          const SizedBox(height: 16),
          _customField(
            controller: _message,
            hint: 'How can we help?',
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 6,
            maxLength: 1000,
          ),
          
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                final name = _name.text.trim();
                final email = _email.text.trim();
                final message = _message.text.trim();

                if (name.isEmpty || email.isEmpty || message.isEmpty) {
                  await EasyLoading.showError('Please fill all fields');
                  return;
                }

                if (!_emailRegex.hasMatch(email)) {
                  await EasyLoading.showError('Please enter a valid email');
                  return;
                }

                try {
                  await EasyLoading.show(status: 'Sending...');
                  final response = await Utils().contact(name, email, message);
                  if (response['status'] == false) {
                    await EasyLoading.showError(response['message']);
                  } else {
                    await EasyLoading.showSuccess('Message Sent!');
                    if (mounted) Navigator.of(context).pop();
                  }
                } catch (_) {
                  await EasyLoading.showError('Error');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: NgoPalette.navy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text(
                'Submit Request',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Expanded(
      flex: value.length > 20 ? 2 : 1,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: NgoPalette.primary, size: 20),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF8E8E93))),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: NgoPalette.ink),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          prefixIcon: Icon(icon, color: NgoPalette.primary.withValues(alpha: 0.5), size: 20),
          border: InputBorder.none,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
