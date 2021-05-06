import 'package:flutter/material.dart';

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
          title: Text('About Us'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: new CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
                child: Image.asset(
                  'assets/images/elizabeth.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Elizabeth Lou",
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
                    "Elizabeth Lou came to the United States as a refugee and resettled in San Diego in 1999. Drawing from resources in both her personal background and profession as a community organizer and health educator, she founded Nile Sisters Development Initiative in 2001. The organization’s mission is to educate, support, and offer training to refugee and immigrant women and their families to help them overcome barriers to social and economic self-reliance. Her commitment to the refugee and immigrant population in San Diego County has earned the following recognition at local, state and national levels.",
                   // textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
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
                    "Our Mission",
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
                    "The Nile Sisters Development Initiative mission is to educate, support, and offer training to refugee and immigrant women and their families to help them overcome barriers to social and economic self-reliance..",
                   //   textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
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
                    "Our History",
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
                    "Nile Sisters Development Initiative is a California nonprofit 501(c)(3) charitable organization, founded in 2001 by Elizabeth Lou. Being intimately acquainted with the daunting challenges facing a refugee entering the United States, Elizabeth wanted to provide a broad array of services to help refugees and immigrants in San Diego to acculturate and assimilate a new language, customs, and systems that are inherent to the American way of life.",
                    //textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
