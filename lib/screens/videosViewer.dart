import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/videos.dart';
import 'package:nilesisters/screens/video_api.dart';
import 'package:url_launcher/url_launcher.dart';
class VideoViewer extends StatefulWidget {
  @override
  _VideoViewerState createState() => _VideoViewerState();
}
class _VideoViewerState extends State<VideoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Videos'),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchVideos(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){
                  GetVideos videos = snapshot.data[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 300,
                            //child: VideoPlayerScreen()
                          ),
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
    );
  }
}
