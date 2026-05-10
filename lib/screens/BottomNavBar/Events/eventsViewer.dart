import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getEvents.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/calenderView.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/eventDetails.dart';
import 'package:nilesisters/utils/Utils.dart';

class EventsViewer extends StatefulWidget {
  @override
  State<EventsViewer> createState() => _EventsViewerState();
}

class _EventsViewerState extends State<EventsViewer> with SingleTickerProviderStateMixin {
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
      body: FutureBuilder<GetEvents>(
        future: Utils().fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: NgoPalette.primary));
          }

          if (snapshot.hasError) {
            return _buildErrorState(context, 'Unable to load events', snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return _buildErrorState(context, 'No events found', 'Check back later for upcoming community programs.');
          }

          final events = snapshot.data!;

          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Premium SliverAppBar
                  SliverAppBar(
                    expandedHeight: 400.0,
                    pinned: true,
                    stretch: true,
                    backgroundColor: NgoPalette.navy,
                    elevation: 0,
                    automaticallyImplyLeading: false, // Back button handled by bottom nav
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Events',
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
                              'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=2070&auto=format&fit=crop',
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
                                      'COMMUNITY HUB',
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
                                    'Participate &\nMake Impact',
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

                  // Events List Sections
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
                                title: 'Upcoming Events',
                                subtitle: 'Join our programs, community drives, and interactive gatherings.',
                              ),
                            ),
                            const SizedBox(height: 30),
                            ...events.data.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final event = entry.value;
                                return _EntranceAnimation(
                                  delay: 600 + (index * 150),
                                  type: EntranceType.slideUp,
                                  child: _PremiumEventCard(event: event),
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
              child: const Icon(Icons.event_busy_rounded, size: 60, color: NgoPalette.primary),
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

class _PremiumEventCard extends StatelessWidget {
  const _PremiumEventCard({required this.event});

  final dynamic event;

  @override
  Widget build(BuildContext context) {
    final dateParts = event.date.split('/');
    
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
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    '${Utils().image_base_url}${event.file}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          dateParts[1],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: NgoPalette.primary,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          _getMonthName(int.parse(dateParts[0])),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: NgoPalette.muted,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: NgoPalette.ink,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _EventPill(label: event.time, icon: Icons.schedule_rounded),
                      _EventPill(label: event.location, icon: Icons.place_rounded),
                      _EventPill(label: event.fee, icon: Icons.payments_rounded, isHighlight: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    event.details,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: NgoPalette.muted.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionBtn(
                          label: 'Learn More',
                          icon: Icons.info_outline_rounded,
                          isPrimary: false,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetail(
                                  title: event.title,
                                  benefits: event.benefits,
                                  date: event.date,
                                  time: event.time,
                                  location: event.location,
                                  fee: event.fee,
                                  details: event.details,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionBtn(
                          label: 'Calendar',
                          icon: Icons.event_available_rounded,
                          isPrimary: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DynamicEvent(
                                  year: int.parse(dateParts[2]),
                                  month: int.parse(dateParts[0]),
                                  day: int.parse(dateParts[1]),
                                  title: event.title,
                                ),
                              ),
                            );
                          },
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

  String _getMonthName(int month) {
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[month - 1];
  }
}

class _EventPill extends StatelessWidget {
  const _EventPill({required this.label, required this.icon, this.isHighlight = false});

  final String label;
  final IconData icon;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? NgoPalette.primary.withValues(alpha: 0.08) : NgoPalette.sky.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? NgoPalette.primary.withValues(alpha: 0.2) : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: isHighlight ? NgoPalette.primary : NgoPalette.muted),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isHighlight ? NgoPalette.primary : NgoPalette.ink,
              ),
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
    required this.isPrimary,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
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
      icon: Icon(icon, size: 18),
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
