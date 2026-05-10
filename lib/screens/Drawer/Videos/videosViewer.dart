import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getVideos.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoViewer extends StatefulWidget {
  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(DemoLocalization.of(context).getTranslatedValue('videos')),
      ),
      body: FutureBuilder<GetVideos>(
        future: Utils().fetchvideos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final videos = snapshot.data!;
          return ListView.builder(
            itemCount: videos.data.length,
            itemBuilder: (BuildContext context, index) {
              final video = videos.data[index];

              Future<void> launchVideo() async {
                if (await canLaunch(video.link)) {
                  await launch(video.link);
                } else {
                  throw 'Could not launch ${video.link}';
                }
              }

              return Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                        child: Text('Video Title', style: TextStyle(color: CustomColors().grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(video.title, style: TextStyle(color: CustomColors().redicon)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                        child: Text('Video Link', style: TextStyle(color: CustomColors().grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: launchVideo,
                          child: Text(video.link, style: TextStyle(color: CustomColors().secondaryColor)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 2),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
