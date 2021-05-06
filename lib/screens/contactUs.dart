import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  _launchSanDiegoCaller() async {
    const url = "tel:6192652959";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleCaller() async {
    const url = "tel:8184035119";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCallerEnglish() async {
    const url = "tel:18007352922";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCallerSpanish() async {
    const url = "tel:18008553000";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSanDiegoMailer() async {
    const url = "mailto:info@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleMailer() async {
    const url = "mailto:info.la@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSanDiegoMap() async {
    const url =
        "https://www.google.com/maps/place/5532+El+Cajon+Blvd+%235,+San+Diego,+CA+92115,+USA/@32.7588005,-117.0776665,17z/data=!3m1!4b1!4m5!3m4!1s0x80d9569ee50c9e5f:0x13ac1399d3d79550!8m2!3d32.7588005!4d-117.0754778";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleMap() async {
    const url =
        "https://www.google.com/maps/place/100+N+Brand+Blvd+UNIT+219,+Glendale,+CA+91203,+USA/@34.1465191,-118.2569264,17z/data=!3m1!4b1!4m5!3m4!1s0x80c2c0ff8fc4bd21:0xd574952757c34cd3!8m2!3d34.1465191!4d-118.2547377";
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
              child: new Center(
                child: Text(
                  "Nile Sisters Development Initiative",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'San Diego Office',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Address:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '5532 El Cajon Blvd, San Diego,\n CA 92115, United States',
                        //style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Phone:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+1 619-265-2959',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Email:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        'info@nilesisters.org',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoMap();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoCaller();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoMailer();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Glendale Office',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Address:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '100 North Brand Blvd., Suite 219,\n Glendale, CA 91203, United States',
                       // style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Phone:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+1 818-403-5119',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Email:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        'info.la@nilesisters.org',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleMap();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleCaller();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleMailer();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'TTY Users',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'English:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '1 800-735-2922',
                        // style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Spanish:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+1 800-855-3000',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerEnglish();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerSpanish();
                            },
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        'English:',
                        style: TextStyle(
                            color: Colors.grey,
                            ),
                      ),
                      trailing: Text(
                        'Spanish',
                        style: TextStyle(color: Colors.grey,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Social Networks',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Website:',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        'www.nilesisters.org',
                        // style: TextStyle(fontSize: 16),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.facebook_square,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerEnglish();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.facebook_square,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerSpanish();
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.instagram,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerEnglish();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.instagram,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerSpanish();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
