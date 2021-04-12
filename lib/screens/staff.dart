import 'package:flutter/material.dart';
class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}
class _StaffState extends State<Staff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Staff'),
      ),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(20.0,20.0,10.0,0.0),
              child: new Center(
                child: Text("Our Refugee Advocates are most Valuable Assets",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
                ),
              ),
          ),
          Padding(padding: const EdgeInsets.all(25.0),
              child: new Center(
                child:
                new RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: 'Since its foundation in 2001, Nile Sisters Development Initiative ( NSDI ) has made it a priority to involve stakeholders. Our staff is a genuine reflection of this goal. \n\n'),
                      new TextSpan(text: 'Rebecca Paida \n\n', style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: 'MPH CHES Senior Program Manager \n\n'),
                      new TextSpan(text: 'Patricia Wakhusama, \n\n', style: new TextStyle(fontWeight: FontWeight.bold)),
                      new TextSpan(text: 'MA Community Engagement Specialist \n\n'),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
