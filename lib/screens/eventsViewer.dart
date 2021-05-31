import 'package:nilesisters/API_Data/events.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/events_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'calenderView.dart';

class EventsViewer extends StatefulWidget {
  @override
  _EventsViewerState createState() => _EventsViewerState();
}

class _EventsViewerState extends State<EventsViewer> {
  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      const url = 'https://nilesisters.org/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Eventss eventss = snapshot.data[index];
                  int year = eventss.dates.year;
                  int month = eventss.dates.month;
                  int day = eventss.dates.day;
                  String title = eventss.title;
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              '${eventss.title}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('event_name'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              '${eventss.title}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('date'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              '${eventss.dates.day}' +
                                  '-' +
                                  '${eventss.dates.month}' +
                                  '-' +
                                  '${eventss.dates.year}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('time'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              '${eventss.starttime} to ${eventss.endtime}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('location'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              ' ${eventss.location}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('admission'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              ' ${eventss.fee}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('benefits'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              ' ${eventss.benifits}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            child: TextButton(
                                child: Text(
                                  'Show on Calender',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DynamicEvent(
                                            year: year,
                                            month: month,
                                            day: day,
                                            title: title),
                                      ));
                                }),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            color: Colors.blue,
                            child: TextButton(
                                child: Text(
                                  'Show on Map',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  double lat = double.parse(eventss.lat);
                                  double longg = double.parse(eventss.log);
                                  print(lat);
                                  print(longg);
                                  MapUtils.openMap(lat, longg);
                                }),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
