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
          title: Text('Founder'),
        ),
        body: ListView(
          children: [
            Padding(padding: const EdgeInsets.only(top: 30.0),
              child: new CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
                child: Image.asset(
                  'assets/images/elizabeth.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),
                child: new Center(
                  child: Text("Elizabeth Lou",
                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
            ),
            Padding(padding: const EdgeInsets.all(10.0),
                child: new Center(
                  child: Text("Elizabeth Lou came to the United States as a refugee and resettled in San Diego in 1999. Drawing from resources in both her personal background and profession as a community organizer and health educator, she founded Nile Sisters Development Initiative in 2001. The organization’s mission is to educate, support, and offer training to refugee and immigrant women and their families to help them overcome barriers to social and economic self-reliance. Her commitment to the refugee and immigrant population in San Diego County has earned the following recognition at local, state and national levels.",
                    style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
