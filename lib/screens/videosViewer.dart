import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/videos.dart';
import 'package:nilesisters/screens/video_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'chewie_list_item.dart';
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
                  return
                    Card(
                      elevation: 5,
                    child:ChewieListItem(
                    videoPlayerController: VideoPlayerController.network(
                      videos.videourl,
                    ),
                  ));
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
