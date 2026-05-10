import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getResources.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';
import 'package:nilesisters/screens/BottomNavBar/Resources/viewResource.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> with SingleTickerProviderStateMixin {
  bool downloading = false;
  String progress = '0';
  String currentDownloadingTitle = '';
  late AnimationController _headerController;
  late Animation<double> _imageScale;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _imageScale = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  Future<void> downloadFile(String uri, String fileName) async {
    setState(() {
      downloading = true;
      currentDownloadingTitle = fileName;
    });

    try {
      final savePath = await getFilePath(fileName);
      final dio = Dio();

      await dio.download(
        uri,
        savePath,
        onReceiveProgress: (rcv, total) {
          setState(() {
            progress = total <= 0 ? '0' : ((rcv / total) * 100).toStringAsFixed(0);
          });

          if (progress == '100') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreen(path: savePath),
              ),
            );
          }
        },
        deleteOnError: true,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading document: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          downloading = false;
          currentDownloadingTitle = '';
        });
      }
    }
  }

  Future<String> getFilePath(String uniqueFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/${uniqueFileName.replaceAll(' ', '_')}.pdf';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: const NgoBottomNavBar(),
      body: FutureBuilder<GetResources>(
        future: Utils().fetchResources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: NgoPalette.primary));
          }

          if (snapshot.hasError) {
            return _buildErrorState(context, 'Unable to load library', snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return _buildErrorState(context, 'Library is empty', 'Check back later for new reports and documents.');
          }

          final resources = snapshot.data!;

          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Premium SliverAppBar
                  SliverAppBar(
                    expandedHeight: 380.0,
                    pinned: true,
                    stretch: true,
                    backgroundColor: NgoPalette.navy,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Resources',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 16),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          ScaleTransition(
                            scale: _imageScale,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?q=80&w=2056&auto=format&fit=crop',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black26,
                                  Colors.transparent,
                                  NgoPalette.navy,
                                ],
                                stops: [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 60,
                            left: 24,
                            right: 24,
                            child: _EntranceAnimation(
                              delay: 300,
                              type: EntranceType.slideUp,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: NgoPalette.primary,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: NgoPalette.primary.withValues(alpha: 0.4),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                    ),
                                    child: const Text(
                                      'KNOWLEDGE BASE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Insights &\nOfficial Reports',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w900,
                                      height: 1.0,
                                      letterSpacing: -1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Resource List Sections
                  SliverToBoxAdapter(
                    child: NgoBackground(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 120),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _EntranceAnimation(
                              delay: 500,
                              type: EntranceType.slideUp,
                              child: NgoSectionHeader(
                                title: 'Resource Library',
                                subtitle: 'Access our full collection of research, reports, and public documentation.',
                              ),
                            ),
                            const SizedBox(height: 30),
                            ...resources.data.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final resource = entry.value;
                                return _EntranceAnimation(
                                  delay: 600 + (index * 150),
                                  type: EntranceType.slideUp,
                                  child: _PremiumResourceCard(
                                    resource: resource,
                                    isDownloading: downloading && currentDownloadingTitle == resource.title,
                                    progress: progress,
                                    onDownload: () => downloadFile('${Utils().image_base_url}${resource.file}', resource.title),
                                  ),
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: NgoPalette.sky,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.library_books_rounded, size: 60, color: NgoPalette.primary),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: NgoPalette.ink),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: NgoPalette.muted, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: NgoPrimaryButton(
                label: 'Retry',
                onPressed: () => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumResourceCard extends StatelessWidget {
  const _PremiumResourceCard({
    required this.resource,
    required this.isDownloading,
    required this.progress,
    required this.onDownload,
  });

  final dynamic resource;
  final bool isDownloading;
  final String progress;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: NgoPalette.navy.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: NgoPalette.heroGradient,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: NgoPalette.primary.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Icon(Icons.description_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: NgoPalette.ink,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              resource.edition,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: NgoPalette.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(width: 4, height: 4, decoration: const BoxDecoration(color: NgoPalette.muted, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Text(
                              '${resource.totalPages} Pages',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: NgoPalette.muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        '${Utils().image_base_url}${resource.icon}',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.4)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.context,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: NgoPalette.muted.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _ResourceActionBtn(
                          label: 'Preview',
                          icon: Icons.visibility_rounded,
                          isPrimary: false,
                          onPressed: onDownload,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ResourceActionBtn(
                          label: isDownloading ? '$progress%' : 'Download',
                          icon: isDownloading ? null : Icons.file_download_outlined,
                          isPrimary: true,
                          isLoading: isDownloading,
                          onPressed: onDownload,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceActionBtn extends StatelessWidget {
  const _ResourceActionBtn({
    required this.label,
    this.icon,
    required this.isPrimary,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? NgoPalette.primary : Colors.white,
        foregroundColor: isPrimary ? Colors.white : NgoPalette.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isPrimary ? BorderSide.none : BorderSide(color: NgoPalette.primary.withValues(alpha: 0.2)),
        ),
      ),
      icon: isLoading 
        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
        : (icon != null ? Icon(icon, size: 18) : const SizedBox.shrink()),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
      ),
    );
  }
}

enum EntranceType { slideUp, scale }

class _EntranceAnimation extends StatefulWidget {
  const _EntranceAnimation({
    required this.child,
    required this.delay,
    required this.type,
  });

  final Widget child;
  final int delay;
  final EntranceType type;

  @override
  State<_EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<_EntranceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );

    _slide = Tween<Offset>(
      begin: widget.type == EntranceType.slideUp ? const Offset(0, 0.2) : Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _scale = Tween<double>(begin: widget.type == EntranceType.scale ? 0.85 : 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(_slide.value.dx * 100, _slide.value.dy * 100),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
