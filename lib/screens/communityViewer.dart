import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CommunityViewer extends StatefulWidget {
  @override
  _CommunityViewerState createState() => _CommunityViewerState();
}
class _CommunityViewerState extends State<CommunityViewer> {
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

          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){

                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          new RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: ''),
                                new TextSpan(text: ''),
                              ],
                            ),
                          ),
                          new Icon(Icons.post_add, )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: (){},
        child: Icon(Icons.post_add_outlined),
      ),
    );
  }
}
