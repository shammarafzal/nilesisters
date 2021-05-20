import 'package:nilesisters/API_Data/pdf.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String filename = 'test.pdf';

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
        child: FutureBuilder(
          future: fetchPdfs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Pdf pdfs = snapshot.data[index];
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
                              '${pdfs.title}',
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
                              '${pdfs.title}',
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
                              '${pdfs.edition}',
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
                              '${pdfs.contect}',
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
                              ' ${pdfs.format}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('page_size'),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              ' ${pdfs.pagesize}',
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
                              ' ${pdfs.pagecount}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          new Image.network(
                            '${pdfs.pdfimage}',
                            fit: BoxFit.cover,
                          ),
                          new RaisedButton(
                            onPressed: () async {
                              var url = '${pdfs.pdfurl}';
                              downloadFile(url, filename);
                              /*if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }*/
                            },
                            color: Colors.blue,
                            child: new Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('download'),
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
