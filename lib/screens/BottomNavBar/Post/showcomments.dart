import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getComments.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/viewFullMessage.dart';
import 'package:nilesisters/utils/Utils.dart';

class ShowComments extends StatefulWidget {
  final int postID;
  const ShowComments({
    super.key,
    required this.postID,
  });

  @override
  State<ShowComments> createState() => _ShowCommentsState();
}

class _ShowCommentsState extends State<ShowComments> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return NgoPageShell(
      title: 'Comments',
      subtitle: 'Read the conversation under a community post.',
      child: FutureBuilder<GetComments>(
        future: Utils().fetchcomments(widget.postID.toString()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final comments = snapshot.data!;
          
          if (comments.data.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: NgoPalette.sky, shape: BoxShape.circle),
                      child: const Icon(Icons.chat_bubble_outline_rounded, size: 60, color: NgoPalette.primary),
                    ),
                    const SizedBox(height: 24),
                    const Text('No replies yet', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NgoPalette.ink)),
                    const SizedBox(height: 12),
                    const Text('Be the first to join the conversation!', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: NgoPalette.muted, height: 1.5)),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 110),
            children: [
              const NgoSectionHeader(
                title: 'Thread replies',
                subtitle: 'Each reply keeps the conversation active and visible.',
              ),
              const SizedBox(height: 8),
              ...comments.data.map(
                (comment) => NgoCard(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewFullMessage(
                            postID: int.tryParse(comment.postId) ?? widget.postID,
                            user_name: comment.user.name,
                            user_email: comment.user.email,
                            post_date: _formatDate(comment.createdAt),
                            post_text: comment.comment,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: NgoPalette.sky,
                              child: Text(
                                comment.user.name.isNotEmpty ? comment.user.name[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  color: NgoPalette.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.user.name,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: NgoPalette.ink),
                                  ),
                                  Text(
                                    comment.user.email,
                                    style: const TextStyle(fontSize: 13, color: NgoPalette.muted, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatDate(comment.createdAt),
                                    style: const TextStyle(fontSize: 11, color: NgoPalette.muted, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          comment.comment,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, height: 1.5, color: NgoPalette.muted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} · ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
