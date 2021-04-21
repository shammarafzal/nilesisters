import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class VideoViewer extends StatefulWidget {
  @override
  _VideoViewerState createState() => _VideoViewerState();
}
class _VideoViewerState extends State<VideoViewer> {
  _launchURL() async {
    const url = 'https://youtu.be/dqehPPk9sGk';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL1() async {
    const url = 'https://www.facebook.com/nilesisters/videos/1556260844458588/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    const url = 'https://www.facebook.com/nilesisters/videos/1218385274912815/';
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
          title: Text('Videos'),
        ),
        body: ListView(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(20.0,20.0,10.0,0.0),
                child: new Center(
                  child: Text("Nile Sisters Development Initiative",
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

                        new TextSpan(text: 'NileSisters \t\t https://youtu.be/dqehPPk9sGk \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchURL();
                        }),
                        new TextSpan(text: 'NileSisters Intro\t\t https://www.facebook.com/nilesisters/videos/1556260844458588/ \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchURL1();
                        }),
                        new TextSpan(text: 'NileSisters Female Genital Cutting \t\t https://www.facebook.com/nilesisters/videos/1218385274912815/ \n\n',style: linkStyle,recognizer: TapGestureRecognizer()..onTap = (){
                          _launchURL2();
                        }),
                      ],
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
