import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getVideos.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:video_player/video_player.dart';
import 'chewie_list_item.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/customColors.dart';
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
          title: Text(DemoLocalization.of(context)
              .getTranslatedValue('videos')),
        ),
        body: FutureBuilder<GetVideos>(
            future: Utils().fetchvideos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top:30)),
                          Row(
                            children: [
                              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                                child: new Text('Video Title', style: TextStyle(color: CustomColors().grey)),),
                              Padding(padding: EdgeInsets.all(5.0),
                                child: new Text(snapshot.data.data[index].title, style: TextStyle(color:CustomColors().redicon),), )
                            ],
                          ),

                          Row(
                            children: [
                              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                                child: new Text('Video Link', style: TextStyle(color: CustomColors().grey)),),
                              Padding(padding: EdgeInsets.all(5.0),
                                child: new Text(snapshot.data.data[index].link, style: TextStyle(color:CustomColors().secondaryColor),), )
                            ],
                          ),
                          Divider(height:2),
                        ],
                      );
                    }
                );
                // );
              }
              return Center(child: CircularProgressIndicator());
            }
        )
      // body: Container(
      //   child: FutureBuilder<GetVideos>(
      //     future: Utils().fetchvideos(),
      //     builder: (context,snapshot){
      //       if(snapshot.hasData){
      //         return ListView.builder(
      //           itemCount: snapshot.data.data.length,
      //           shrinkWrap: true,
      //           itemBuilder: (BuildContext context, index ){
      //             return
      //               Card(
      //                 elevation: 5,
      //               child:ChewieListItem(
      //               videoPlayerController: VideoPlayerController.network(
      //                 Utils().image_base_url+'${snapshot.data.data[index].file}',
      //               ),
      //             ));
      //           },
      //         );
      //       }
      //       return Center(child: CircularProgressIndicator());
      //     },
      //   ),
      // ),
    );
  }
}
