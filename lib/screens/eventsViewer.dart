import 'package:nilesisters/API_Data/events.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/events_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){
                  Eventss eventss = snapshot.data[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: Text('${eventss.title}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),),),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('event_name'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${eventss.title}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('date'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${eventss.dates}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('time'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${eventss.starttime} to ${eventss.endtime}',style: TextStyle(fontSize: 20),),

                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('location'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${eventss.location}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('admission'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${eventss.fee}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('benefits'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${eventss.benifits}',style: TextStyle(fontSize: 20),),
                          ),
                          // new RichText(
                          //   text: new TextSpan(
                          //     style: new TextStyle(
                          //       fontSize: 14.0,
                          //       color: Colors.black,
                          //     ),
                          //     children: <TextSpan>[
                          //       new TextSpan(text: '${eventss.title} \n\n',style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                          //       new TextSpan(text: 'Events \t\t\t\t\t\t  ${eventss.title} \n\n'),
                          //       new TextSpan(text: 'Date \t\t\t\t\t\t  ${eventss.dates} \n\n'),
                          //       new TextSpan(text: 'Time \t\t\t\t\t\t  ${eventss.starttime} - ${eventss.endtime}  \n\n'),
                          //       new TextSpan(text: 'Location \t\t\t\t\t\t  ${eventss.location} \n\n'),
                          //       new TextSpan(text: 'Admission \t\t\t\t\t\t  ${eventss.fee} \n\n'),
                          //       new TextSpan(text: 'Benefits \t\t\t\t\t\t  ${eventss.benifits} \n\n'),
                          //     ],
                          //   ),
                          // ),
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
