import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getAbout.dart';
import 'package:nilesisters/utils/Utils.dart';

class founder extends StatefulWidget {
  @override
  State<founder> createState() => _founderState();
}

class _founderState extends State<founder> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(DemoLocalization.of(context).getTranslatedValue('home')),
        ),
        body: FutureBuilder<GetAbout>(
          future: Utils().fetchabout(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final about = snapshot.data!;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.network(
                    '${Utils().image_base_url}${about.data.image}',
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Background',
                        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
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
                        about.data.description,
                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DemoLocalization.of(context).getTranslatedValue('our_mission'),
                        style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
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
                        about.data.mission,
                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DemoLocalization.of(context).getTranslatedValue('our_history'),
                        style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
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
                        about.data.history,
                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
