import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getVideos.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoViewer extends StatefulWidget {
  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  @override
  Widget build(BuildContext context) {
    return NgoPageShell(
      title: 'Video Gallery',
      subtitle: 'Watch our stories and community updates.',
      child: FutureBuilder<GetVideos>(
        future: Utils().fetchvideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: NgoPalette.primary));
          }

          if (snapshot.hasError) {
            return _buildErrorState('Unable to load gallery', snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return _buildErrorState('Gallery is empty', 'Check back later for new content!');
          }

          final videos = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
            itemCount: videos.data.length,
            itemBuilder: (context, index) {
              return _PremiumVideoCard(video: videos.data[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_library_outlined, size: 60, color: NgoPalette.muted),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NgoPalette.ink)),
            const SizedBox(height: 12),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: NgoPalette.muted)),
          ],
        ),
      ),
    );
  }
}

class _PremiumVideoCard extends StatefulWidget {
  final Datum video;
  const _PremiumVideoCard({required this.video});

  @override
  State<_PremiumVideoCard> createState() => _PremiumVideoCardState();
}

class _PremiumVideoCardState extends State<_PremiumVideoCard> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.video.link) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (mounted && _isPlayerReady && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: NgoPalette.navy.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: NgoPalette.primary,
              onReady: () {
                _isPlayerReady = true;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: NgoPalette.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: NgoPalette.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.video.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: NgoPalette.ink,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Watch our mission in action. This video highlights our recent community engagement and service initiatives.',
                  style: TextStyle(
                    fontSize: 14,
                    color: NgoPalette.ink.withValues(alpha: 0.6),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

