import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';

class DynamicEvent extends StatefulWidget {
  final int year;
  final int month;
  final int day;
  final String title;

  const DynamicEvent({
    super.key,
    required this.year,
    required this.month,
    required this.day,
    required this.title,
  });

  @override
  State<DynamicEvent> createState() => _DynamicEventState();
}

class _DynamicEventState extends State<DynamicEvent> with TickerProviderStateMixin {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late final Map<DateTime, List<String>> _events;
  List<String> _selectedEvents = <String>[];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(widget.year, widget.month, widget.day);
    _focusedDay = _selectedDay;
    _events = {
      DateTime(widget.year, widget.month, widget.day): [widget.title]
    };
    _selectedEvents = _events[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)] ?? <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return NgoPageShell(
      title: 'Event Calendar',
      subtitle: 'Schedule of community programs and upcoming sessions.',
      child: Column(
        children: [
          _EntranceAnimation(
            delay: 200,
            type: EntranceType.scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NgoCard(
                padding: const EdgeInsets.all(8),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.month,
                  eventLoader: (day) {
                    return _events[DateTime(day.year, day.month, day.day)] ?? const <String>[];
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: NgoPalette.ink,
                    ),
                    leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: NgoPalette.primary),
                    rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: NgoPalette.primary),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: NgoPalette.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(
                      color: NgoPalette.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: NgoPalette.primary,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                    defaultTextStyle: const TextStyle(fontWeight: FontWeight.w600, color: NgoPalette.ink),
                    weekendTextStyle: const TextStyle(fontWeight: FontWeight.w600, color: NgoPalette.muted),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedEvents = _events[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ?? <String>[];
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SCHEDULED EVENTS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: NgoPalette.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_selectedEvents.isEmpty)
                    _EntranceAnimation(
                      delay: 400,
                      type: EntranceType.slideUp,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            'No events scheduled for this day.',
                            style: TextStyle(color: NgoPalette.muted.withValues(alpha: 0.7), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _selectedEvents.length,
                        itemBuilder: (context, index) {
                          return _EntranceAnimation(
                            delay: 400 + (index * 100),
                            type: EntranceType.slideUp,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: NgoPalette.navy.withValues(alpha: 0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                                border: Border.all(color: NgoPalette.primary.withValues(alpha: 0.05)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: NgoPalette.primary.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.event_note_rounded, color: NgoPalette.primary, size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      _selectedEvents[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: NgoPalette.ink,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
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
      duration: const Duration(milliseconds: 800),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );

    _slide = Tween<Offset>(
      begin: widget.type == EntranceType.slideUp ? const Offset(0, 0.15) : Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _scale = Tween<double>(begin: widget.type == EntranceType.scale ? 0.9 : 1.0, end: 1.0).animate(
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
