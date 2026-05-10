import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';

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

class _EventDetailState extends State<EventDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Nilesisters'),
      ),
      body: new ListView(
        children: <Widget>[
          ListTile(
            title: new Text('Event Name'),
            subtitle: new Text(widget.title),
          ),
          Divider(),
          ListTile(
            title: new Text('Benefits'),
            subtitle: new Text(widget.benefits),
          ),
          Divider(),
          ListTile(
            title: new Text('Details'),
            subtitle: new Text(widget.details),
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Event Date', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.date, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Event Time', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.time, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
          Divider(),
          Row(
             // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text('Location', style: TextStyle(color: CustomColors().grey)),),
              ),
              Expanded(
              child: Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.location, style: TextStyle(color: CustomColors().secondaryColor),), ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Fee', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.fee, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
        ],
      ),
    );
  }
}
