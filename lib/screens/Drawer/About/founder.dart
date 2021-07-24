import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getAbout.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:nilesisters/Localization/demo_localization.dart';

class founder extends StatefulWidget {
  @override
  _founderState createState() => _founderState();
}

class _founderState extends State<founder> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(DemoLocalization.of(context)
              .getTranslatedValue('home')),
        ),
        body: FutureBuilder<GetAbout>(
                future:  Utils().fetchabout(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.network(
                              Utils().image_base_url +
                                  '${snapshot.data.data.image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Background",
                                  style: TextStyle(fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.data.description,
                                  style:
                                  TextStyle(fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DemoLocalization.of(context)
                                      .getTranslatedValue('our_mission'),
                                  style: TextStyle(fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.data.mission,
                                  //   textAlign: TextAlign.center,
                                  style:
                                  TextStyle(fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DemoLocalization.of(context)
                                      .getTranslatedValue('our_history'),
                                  style: TextStyle(fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.data.history,
                                  //textAlign: TextAlign.center,
                                  style:
                                  TextStyle(fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                  // );
                  }
                  return Center(child: CircularProgressIndicator());
                }
            )
      ),
    );
  }
}
