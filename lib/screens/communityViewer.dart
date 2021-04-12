import 'package:nilesisters/API_Data/communtiy.dart';
import 'package:nilesisters/API_Data/pdf.dart';
import 'package:nilesisters/screens/community_api.dart';
import 'package:nilesisters/screens/pdf_api.dart';
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
          future: fetchcommunity(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){
                  Community comm = snapshot.data[index];
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
                                new TextSpan(text: '${comm.username} \t\t\t\t\t\t  ${comm.timess} \n\n'),
                                new TextSpan(text: '${comm.posttext}\n\n'),
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
