import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getVideos.dart';
import 'package:nilesisters/utils/Utils.dart';
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
        child: FutureBuilder<GetVideos>(
          future: Utils().fetchvideos(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){
                  return
                    Card(
                      elevation: 5,
                    child:ChewieListItem(
                    videoPlayerController: VideoPlayerController.network(
                      Utils().image_base_url+'${snapshot.data.data[index].file}',
                    ),
                  ));
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
