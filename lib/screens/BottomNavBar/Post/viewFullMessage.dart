import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/showcomments.dart';
import 'package:nilesisters/utils/Utils.dart';

class ViewFullMessage extends StatefulWidget {
  final int postID;
  final String user_name;
  final String user_email;
  final String post_text;
  final String post_date;

  const ViewFullMessage({
    super.key,
    required this.postID,
    required this.user_name,
    required this.user_email,
    required this.post_text,
    required this.post_date,
  });

  @override
  _ViewFullMessageState createState() => _ViewFullMessageState();
}

class _ViewFullMessageState extends State<ViewFullMessage> {
  final _formKey = GlobalKey<FormState>();
  final messageTextController = TextEditingController();

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  void _showReplyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text('Reply to ${widget.user_name}', style: const TextStyle(fontWeight: FontWeight.w900, color: NgoPalette.ink)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NgoTextField(
                  controller: messageTextController,
                  label: 'Enter your comment',
                  maxLines: 3,
                  maxLength: 500,
                ),
                const SizedBox(height: 24),
                NgoPrimaryButton(
                  label: 'Post Reply',
                  icon: Icons.send_rounded,
                  onPressed: () async {
                    final text = messageTextController.text.trim();
                    if (text.isEmpty) return;
                    try {
                      await EasyLoading.show(status: 'Posting...', maskType: EasyLoadingMaskType.black);
                      final response = await Utils().sendComment(text, widget.postID.toString());
                      if (response['status'] == false) {
                        await EasyLoading.showError(response['message']);
                      } else {
                        await EasyLoading.showSuccess('Reply posted successfully');
                        messageTextController.clear();
                        if (mounted) {
                          Navigator.of(context).pop();
                          // Optionally navigate to thread to see the new reply
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowComments(postID: widget.postID),
                            ),
                          );
                        }
                      }
                    } catch (_) {
                      await EasyLoading.showError('Something went wrong');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NgoPageShell(
      title: 'Post Details',
      subtitle: 'Viewing full community message.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 110),
        children: [
          NgoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: NgoPalette.heroGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.person_rounded, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user_name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: NgoPalette.ink),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.user_email,
                            style: const TextStyle(fontSize: 14, color: NgoPalette.muted, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Message',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: NgoPalette.primary, letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.post_text,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: NgoPalette.ink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(height: 1, color: NgoPalette.sky),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Posted on',
                      style: TextStyle(fontSize: 12, color: NgoPalette.muted, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.post_date,
                      style: const TextStyle(fontSize: 12, color: NgoPalette.ink, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _ActionBtn(
                        label: 'View Thread',
                        icon: Icons.chat_bubble_outline_rounded,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowComments(postID: widget.postID),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionBtn(
                        label: 'Reply',
                        icon: Icons.reply_rounded,
                        isPrimary: true,
                        onPressed: _showReplyDialog,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? NgoPalette.primary : NgoPalette.sky.withValues(alpha: 0.5),
        foregroundColor: isPrimary ? Colors.white : NgoPalette.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: isPrimary ? BorderSide.none : BorderSide(color: NgoPalette.primary.withValues(alpha: 0.1)),
        ),
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
      ),
    );
  }
}


