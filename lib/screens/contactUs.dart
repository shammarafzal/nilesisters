import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}
class _ContactUsState extends State<ContactUs> {
  _launchURL() async {
    const url = 'https://nilesisters.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchCaller() async {
    const url = "tel:6192652959";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchCaller1() async {
    const url = "tel:8184035119";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchCaller2() async {
    const url = "tel:18007352922";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchCaller3() async {
    const url = "tel:18008553000";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchMailer() async {
    const url = "mailto:info@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchMailer1() async {
    const url = "mailto:info.la@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('Contact Us'),
        ),
        body: ListView(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(20.0,20.0,10.0,0.0),
                child: new Center(
                  child: Text("Nile Sisters Development Initiative",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
                  ),
                )
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
                        new TextSpan(text: '5532 El Cajon Blvd., Ste. 5 San Diego, CA 92115–3642. \n\n'),
                        new TextSpan(text: '100 North Brand BBlvd., Suite 219 Glendle CA 91203 \n\n'),
                        new TextSpan(text: 'T \t\t\t\t\t\t   619 265-2959 \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchCaller();
                        }),
                        new TextSpan(text: 'T1 \t\t\t\t\t\t 818 403-5119 \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchCaller1();
                        }),
                        new TextSpan(text: 'TTY Users \t\t 1-800-735-2922, (English) \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchCaller2();
                        }),
                        new TextSpan(text: 'TTY Users \t\t 1-800-855-3000, (Spanish) \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchCaller3();
                        }),
                        new TextSpan(text: 'Email \t\t info@nilesisters.org \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchMailer();
                        }),
                        new TextSpan(text: '\t\t\t\t\t\t\t\t\t\t\t\t info.la@nilesisters.org \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchMailer1();
                        }),
                        new TextSpan(text: 'Website \t\t https://nilesisters.org/ \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchURL();
                        }),
                      ],
                    ),
                  ),
                )
            ),
            Padding(padding: const EdgeInsets.fromLTRB(20.0,20.0,10.0,0.0),
                child: new Center(
                  child: Text("Nile Sisters Development Initiative",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
