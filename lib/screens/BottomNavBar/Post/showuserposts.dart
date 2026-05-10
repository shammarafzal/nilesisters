import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getPosts.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/showcomments.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/viewFullMessage.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowPosts extends StatefulWidget {
  @override
  State<ShowPosts> createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  final messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? currentUserId;
  late Future<GetPosts> _postsFuture;
  Color _currentBackground = const Color(0xFFE5DDD5);

  final List<Map<String, dynamic>> _bgOptions = [
    {'name': 'Classic', 'color': const Color(0xFFE5DDD5)},
    {'name': 'Light Blue', 'color': const Color(0xFFE3F2FD)},
    {'name': 'Soft Green', 'color': const Color(0xFFE8F5E9)},
    {'name': 'Warm Sand', 'color': const Color(0xFFFFF3E0)},
    {'name': 'Dark Navy', 'color': const Color(0xFF1A237E)},
    {'name': 'Modern Grey', 'color': const Color(0xFFF5F5F5)},
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _refreshPosts();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getInt('id');
      // Load saved background if any
      final savedBg = prefs.getInt('chat_bg');
      if (savedBg != null) {
        _currentBackground = Color(savedBg);
      }
    });
  }

  void _saveBackground(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('chat_bg', color.value);
    setState(() {
      _currentBackground = color;
    });
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = Utils().fetchposts();
    });
  }

  @override
  void dispose() {
    messageTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkBg = ThemeData.estimateBrightnessForColor(_currentBackground) == Brightness.dark;

    return Scaffold(
      backgroundColor: _currentBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NgoPalette.navy,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: NgoPalette.primary,
                child: Icon(Icons.group_rounded, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Community Group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    'Tap to view group info',
                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<Color>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: _saveBackground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            itemBuilder: (context) => [
              const PopupMenuItem(
                enabled: false,
                child: Text('Change Background', style: TextStyle(fontWeight: FontWeight.bold, color: NgoPalette.navy)),
              ),
              ..._bgOptions.map((opt) => PopupMenuItem<Color>(
                value: opt['color'],
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: opt['color'],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(opt['name']),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<GetPosts>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: NgoPalette.primary));
            }

            if (snapshot.hasError) {
              return _buildErrorState(context, 'Unable to load feed', snapshot.error.toString());
            }

            final posts = snapshot.data?.data ?? [];
            if (posts.isEmpty) {
              return _buildErrorState(context, 'Feed is empty', 'Be the first to share a story!');
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final isMe = currentUserId != null && post.user.id == currentUserId;
                return _ChatBubble(
                  post: post,
                  isMe: isMe,
                  isDarkBg: isDarkBg,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMessageInput(),
            const SizedBox(height: 10), // Small gap before the floating navbar
            const NgoBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12), // Added bottom padding
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: messageTextController,
                maxLines: 4,
                minLines: 1,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: NgoPalette.primary,
            shape: const CircleBorder(),
            elevation: 4,
            child: InkWell(
              onTap: _sendMessage,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Icon(Icons.send_rounded, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = messageTextController.text.trim();
    if (text.isEmpty) return;
    messageTextController.clear();

    try {
      await EasyLoading.show(status: 'Sending...');
      final response = await Utils().sendPost(text);
      if (response['status'] == false) {
        await EasyLoading.showError(response['message']);
      } else {
        await EasyLoading.dismiss();
        _refreshPosts();
      }
    } catch (_) {
      await EasyLoading.showError('Something went wrong');
    }
  }

  Widget _buildErrorState(BuildContext context, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.forum_outlined, size: 60, color: NgoPalette.muted),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: NgoPalette.ink)),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: NgoPalette.muted)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _refreshPosts, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.post, required this.isMe, required this.isDarkBg});

  final Datum post;
  final bool isMe;
  final bool isDarkBg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 48, bottom: 2),
              child: Text(
                post.user.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDarkBg ? Colors.white70 : NgoPalette.primary,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 20, color: NgoPalette.muted),
                    ),
                  ),
                ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFullMessage(
                          postID: post.id,
                          user_name: post.user.name,
                          user_email: post.user.email,
                          post_date: _formatDate(post.createdAt),
                          post_text: post.post,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFDCF8C6) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          post.post,
                          style: const TextStyle(
                            fontSize: 15, 
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatTime(post.createdAt),
                              style: TextStyle(
                                fontSize: 10, 
                                color: Colors.black.withValues(alpha: 0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 4),
                              Icon(Icons.done_all_rounded, size: 14, color: Colors.blue.shade400),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isMe) const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} · ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

