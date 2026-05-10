import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';

class EventDetail extends StatefulWidget {
  final String title;
  final String benefits;
  final String date;
  final String time;
  final String location;
  final String fee;
  final String details;

  const EventDetail({
    super.key,
    required this.title,
    required this.benefits,
    required this.date,
    required this.time,
    required this.location,
    required this.fee,
    required this.details,
  });

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: const NgoBottomNavBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium SliverAppBar
          SliverAppBar(
            expandedHeight: 350.0,
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
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2070&auto=format&fit=crop',
                    fit: BoxFit.cover,
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
                              'EVENT DETAILS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
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

          // Content
          SliverToBoxAdapter(
            child: NgoBackground(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _EntranceAnimation(
                      delay: 500,
                      type: EntranceType.slideUp,
                      child: _InfoSection(
                        icon: Icons.description_rounded,
                        title: 'Overview',
                        content: widget.details,
                        accentColor: NgoPalette.primary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _EntranceAnimation(
                      delay: 700,
                      type: EntranceType.slideUp,
                      child: _InfoSection(
                        icon: Icons.auto_awesome_rounded,
                        title: 'Benefits & Impact',
                        content: widget.benefits,
                        accentColor: Colors.amber[800]!,
                        highlight: true,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _EntranceAnimation(
                      delay: 900,
                      type: EntranceType.slideUp,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: NgoPalette.navy.withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _LogisticsRow(icon: Icons.calendar_today_rounded, label: 'Date', value: widget.date),
                            const Divider(height: 32),
                            _LogisticsRow(icon: Icons.access_time_rounded, label: 'Time', value: widget.time),
                            const Divider(height: 32),
                            _LogisticsRow(icon: Icons.place_rounded, label: 'Location', value: widget.location),
                            const Divider(height: 32),
                            _LogisticsRow(icon: Icons.payments_rounded, label: 'Admission', value: widget.fee, isHighlight: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.accentColor,
    this.highlight = false,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accentColor, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: NgoPalette.ink,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: NgoPalette.navy.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: highlight ? accentColor.withValues(alpha: 0.15) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: NgoPalette.muted,
              fontWeight: FontWeight.w500,
              fontStyle: highlight ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class _LogisticsRow extends StatelessWidget {
  const _LogisticsRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: NgoPalette.sky,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: NgoPalette.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: NgoPalette.muted,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: isHighlight ? NgoPalette.primary : NgoPalette.ink,
                ),
              ),
            ],
          ),
        ),
      ],
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
