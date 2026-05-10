import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getAbout.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';
import 'package:nilesisters/utils/Utils.dart';

class founder extends StatefulWidget {
  @override
  State<founder> createState() => _founderState();
}

class _founderState extends State<founder> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: const NgoBottomNavBar(),
      body: FutureBuilder<GetAbout>(
        future: Utils().fetchabout(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: NgoPalette.primary));
          }

          final about = snapshot.data!;
          final imageUrl = '${Utils().image_base_url}${about.data.image}';

          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Premium SliverAppBar
                  SliverAppBar(
                    expandedHeight: 450.0,
                    pinned: true,
                    stretch: true,
                    backgroundColor: NgoPalette.navy,
                    elevation: 0,
                    leading: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Founder',
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
                              imageUrl,
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
                                    ),
                                    child: const Text(
                                      'OUR LEGACY',
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
                                    'Empowering\nGenerations',
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

                  // Content Sections
                  SliverToBoxAdapter(
                    child: NgoBackground(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 100),
                        child: Column(
                          children: [
                            _EntranceAnimation(
                              delay: 600,
                              type: EntranceType.scale,
                              child: _PremiumSection(
                                icon: Icons.auto_stories,
                                title: 'The Narrative',
                                content: about.data.description,
                                accentColor: NgoPalette.primary,
                              ),
                            ),
                            const SizedBox(height: 35),
                            _EntranceAnimation(
                              delay: 800,
                              type: EntranceType.slideRight,
                              child: _PremiumSection(
                                icon: Icons.lightbulb_outline,
                                title: 'Strategic Mission',
                                content: about.data.mission,
                                accentColor: Colors.amber[800]!,
                                isHighlighted: true,
                              ),
                            ),
                            const SizedBox(height: 35),
                            _EntranceAnimation(
                              delay: 1000,
                              type: EntranceType.slideLeft,
                              child: _PremiumSection(
                                icon: Icons.history,
                                title: 'Historical Roots',
                                content: about.data.history,
                                accentColor: NgoPalette.navy,
                              ),
                            ),
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
}

class _PremiumSection extends StatelessWidget {
  const _PremiumSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.accentColor,
    this.isHighlighted = false,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: isHighlighted ? accentColor.withValues(alpha: 0.2) : Colors.transparent,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: Icon(
                icon,
                size: 120,
                color: accentColor.withValues(alpha: 0.03),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: accentColor, size: 26),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: NgoPalette.ink,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: NgoPalette.muted.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
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

enum EntranceType { slideUp, slideRight, slideLeft, scale }

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

    Offset startOffset;
    switch (widget.type) {
      case EntranceType.slideUp:
        startOffset = const Offset(0, 0.3);
        break;
      case EntranceType.slideRight:
        startOffset = const Offset(-0.2, 0);
        break;
      case EntranceType.slideLeft:
        startOffset = const Offset(0.2, 0);
        break;
      case EntranceType.scale:
        startOffset = Offset.zero;
        break;
    }

    _slide = Tween<Offset>(begin: startOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _scale = Tween<double>(begin: widget.type == EntranceType.scale ? 0.8 : 1.0, end: 1.0).animate(
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
