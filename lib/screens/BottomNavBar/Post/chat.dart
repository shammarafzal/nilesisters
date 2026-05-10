import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';

class Chat_Screen extends StatefulWidget {
  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final messageTextController = TextEditingController();

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: NgoPalette.navy,
        title: const Text(
          'Create Post',
          style: TextStyle(fontWeight: FontWeight.w900, color: NgoPalette.navy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 110),
        children: [
          const Text(
            'What\'s on your mind?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: NgoPalette.ink,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your post will be shared with the community group.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF8E8E93), // Neutral iOS-style grey
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  controller: messageTextController,
                  maxLines: 12,
                  style: const TextStyle(
                    fontSize: 17,
                    color: NgoPalette.ink,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.grey.shade400),
                      const SizedBox(width: 10),
                      Text(
                        'Post to Global Voices',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: () async {
                if (messageTextController.text.trim().isEmpty) return;
                try {
                  await EasyLoading.show(status: 'Posting...');
                  final response = await Utils().sendPost(messageTextController.text);
                  if (response['status'] == false) {
                    await EasyLoading.showError(response['message']);
                  } else {
                    await EasyLoading.showSuccess('Posted!');
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                'Post to Community',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
