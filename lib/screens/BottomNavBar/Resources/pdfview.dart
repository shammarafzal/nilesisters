import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getResources.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/Resources/viewResource.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool downloading = false;
  String progress = '0';
  bool isDownloaded = false;

  Future<void> downloadFile(String uri, String fileName) async {
    setState(() {
      downloading = true;
    });

    final savePath = await getFilePath(fileName);
    final dio = Dio();

    await dio.download(
      uri,
      savePath,
      onReceiveProgress: (rcv, total) {
        setState(() {
          progress = total == 0 ? '0' : ((rcv / total) * 100).toStringAsFixed(0);
        });

        if (progress == '100') {
          setState(() {
            isDownloaded = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(path: savePath),
            ),
          );
        }
      },
      deleteOnError: true,
    );

    setState(() {
      downloading = false;
      if (progress == '100') {
        isDownloaded = true;
      }
    });
  }

  Future<String> getFilePath(String uniqueFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$uniqueFileName';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetResources>(
        future: Utils().fetchResources(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final resources = snapshot.data!;
          return ListView.builder(
            itemCount: resources.data.length,
            itemBuilder: (BuildContext context, index) {
              final resource = resources.data[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          resource.title,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          DemoLocalization.of(context).getTranslatedValue('title'),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: SizedBox(
                          width: SizeConfig.screenWidth * 0.5,
                          child: Text(
                            resource.title,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          DemoLocalization.of(context).getTranslatedValue('edition'),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Text(resource.edition, style: const TextStyle(fontSize: 20)),
                      ),
                      ListTile(
                        title: Text(
                          DemoLocalization.of(context).getTranslatedValue('context'),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Text(resource.context, style: const TextStyle(fontSize: 20)),
                      ),
                      ListTile(
                        title: Text(
                          DemoLocalization.of(context).getTranslatedValue('format'),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Text(resource.format, style: const TextStyle(fontSize: 20)),
                      ),
                      ListTile(
                        title: Text(
                          DemoLocalization.of(context).getTranslatedValue('page_count'),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Text(resource.totalPages, style: const TextStyle(fontSize: 20)),
                      ),
                      Image.network(
                        '${Utils().image_base_url}${resource.icon}',
                        fit: BoxFit.cover,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final url = '${Utils().image_base_url}${resource.file}';
                          await downloadFile(url, resource.title);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
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
        },
      ),
    );
  }
}
