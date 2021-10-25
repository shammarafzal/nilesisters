import 'package:nilesisters/Model/getResources.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/screens/BottomNavBar/Resources/viewResource.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:share/share.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfViewer extends StatefulWidget {
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool downloading = false;
  String progress = '0';
  bool isDownloaded = false;
  String filename = 'nilesisters.pdf';

  Future<void> downloadFile(uri, fileName) async {
    setState(() {
      downloading = true;
    });

    String savePath = await getFilePath(fileName);

    Dio dio = Dio();

    dio.download(
      uri,
      savePath,
      onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
        });

        if (progress == '100') {
          setState(() {
            isDownloaded = true;
          });
        } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      setState(() {
        if (progress == '100') {
          isDownloaded = true;
        }

        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    Share.shareFiles(['${path}']);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<GetResources>(
          future: Utils().fetchResources(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              snapshot.data.data[index].title,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('title'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              snapshot.data.data[index].title,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('edition'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              snapshot.data.data[index].edition,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('context'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              snapshot.data.data[index].context,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('format'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              snapshot.data.data[index].format,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('page_count'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              snapshot.data.data[index].totalPages,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          new Image.network(
                            Utils().image_base_url+'${snapshot.data.data[index].icon}',
                            fit: BoxFit.cover,
                          ),
                          new RaisedButton(
                            onPressed: () async {
                              var url = Utils().image_base_url+'${snapshot.data.data[index].file}';
                              downloadFile(url, filename);
                            },
                            color: Colors.blue,
                            child: new Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('download'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              var url = Utils().image_base_url+'${snapshot.data.data[index].file}';
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new ViewPDF(url: url),
                                ),
                              );
                            },
                            color: Colors.blue,
                            child: new Text(
                              'View Resource',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
