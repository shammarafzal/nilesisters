import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

class _DynamicEventState extends State<DynamicEvent> {
  late final DateTime _focusedDay;
  late final Map<DateTime, List<String>> _events;
  List<String> _selectedEvents = <String>[];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime(widget.year, widget.month, widget.day);
    _events = {
      DateTime(widget.year, widget.month, widget.day): [widget.title]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Align(
          alignment: Alignment
              .center,
          child: Text("Event Calendar"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              eventLoader: (day) {
                return _events[DateTime(day.year, day.month, day.day)] ?? const <String>[];
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                todayTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(day, _focusedDay);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedEvents = _events[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ?? <String>[];
                });
              },
            ),
            ..._selectedEvents.map((event) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                child: Text(
                        event,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )),
              ),
            )),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),*/
    );
  }
}
