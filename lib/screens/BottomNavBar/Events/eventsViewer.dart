import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getEvents.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/eventDetails.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/calenderView.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsViewer extends StatefulWidget {
  @override
  State<EventsViewer> createState() => _EventsViewerState();
}

class _EventsViewerState extends State<EventsViewer> {
  @override
  Widget build(BuildContext context) {
    Future<void> launchHome() async {
      const url = 'https://nilesisters.org/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: FutureBuilder<GetEvents>(
        future: Utils().fetchEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              final event = events.data[index];
              final date = event.date.split('/');
              return InkWell(
                onTap: () {
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
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('event_name'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: SizedBox(
                            width: SizeConfig.screenWidth * 0.5,
                            child: Text(
                              event.title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('date'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(
                            '${date[0]}/${date[1]}/${date[2]}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('time'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(event.time, style: const TextStyle(fontSize: 20)),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('location'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: SizedBox(
                            width: SizeConfig.screenWidth * 0.5,
                            child: Text(
                              event.location,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('admission'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(event.fee, style: const TextStyle(fontSize: 20)),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('benefits'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: SizedBox(
                            width: SizeConfig.screenWidth * 0.5,
                            child: Text(
                              event.benefits,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context).getTranslatedValue('details'),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: SizedBox(
                            width: SizeConfig.screenWidth * 0.5,
                            child: Text(
                              event.details,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Image.network(
                          '${Utils().image_base_url}${event.file}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DynamicEvent(
                                    year: int.parse(date[2]),
                                    month: int.parse(date[0]),
                                    day: int.parse(date[1]),
                                    title: event.title,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              DemoLocalization.of(context).getTranslatedValue('show_on_calendar'),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
