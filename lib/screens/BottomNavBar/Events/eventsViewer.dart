import 'package:nilesisters/Model/getEvents.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/eventDetails.dart';
import 'package:nilesisters/utils/Utils.dart';
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
        child: FutureBuilder<GetEvents>(
          future:  Utils().fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  var date = snapshot.data.data[index].date.split('-');
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new EventDetail(title: snapshot.data.data[index].title, benefits: snapshot.data.data[index].benefits, date: snapshot.data.data[index].date, time: snapshot.data.data[index].time, location: snapshot.data.data[index].location, fee: snapshot.data.data[index].fee,),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                snapshot.data.data[index].title,
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
                              trailing: Container(
                                width: SizeConfig.screenWidth * 0.5,
                                child: Text(
                                  snapshot.data.data[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  // softWrap: false,
                                  style: TextStyle(fontSize: 20),
                                ),
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
                                snapshot.data.data[index].date,
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
                                snapshot.data.data[index].time,
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
                              trailing: Container(
                                width: SizeConfig.screenWidth * 0.5,
                                child: Text(
                                  snapshot.data.data[index].location,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  // softWrap: false,
                                  style: TextStyle(fontSize: 20),
                                ),
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
                                snapshot.data.data[index].fee,
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
                              trailing: Container(
                                width: SizeConfig.screenWidth * 0.5,
                                child: Text(
                                  snapshot.data.data[index].benefits,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  // softWrap: false,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              child: TextButton(
                                  child: Text(
                                    DemoLocalization.of(context)
                                        .getTranslatedValue('show_on_calendar'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DynamicEvent(
                                              year: int.parse(date[2]),
                                              month: int.parse(date[1]),
                                              day: int.parse(date[0]),
                                              title: snapshot.data.data[index].title),
                                        ));
                                  }),
                            ),
                            SizedBox(height: 5,),
                            // Container(
                            //   color: Colors.blue,
                            //   child: TextButton(
                            //       child: Text(
                            //         'Show on Map',
                            //         style: TextStyle(color: Colors.white),
                            //       ),
                            //       onPressed: () {
                            //         // // double lat = double.parse(eventss.lat);
                            //         // // double longg = double.parse(eventss.log);
                            //         // print(lat);
                            //         // print(longg);
                            //         // MapUtils.openMap(lat, longg);
                            //       }),
                            // )
                          ],
                        ),
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
