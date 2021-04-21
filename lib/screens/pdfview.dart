import 'package:nilesisters/API_Data/pdf.dart';
import 'package:nilesisters/screens/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class PdfViewer extends StatefulWidget {
  @override
  _PdfViewerState createState() => _PdfViewerState();
}
class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchPdfs(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index ){
                  Pdf pdfs = snapshot.data[index];
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
                                new TextSpan(text: 'Title \t\t\t\t\t\t  ${pdfs.title} \n\n'),
                                new TextSpan(text: 'Edition \t\t\t\t\t\t  ${pdfs.edition} \n\n'),
                                new TextSpan(text: 'Contect \t\t\t\t\t\t  ${pdfs.contect} \n\n'),
                                new TextSpan(text: 'Format \t\t\t\t\t\t  ${pdfs.format} \n\n'),
                                new TextSpan(text: 'Page Size \t\t\t\t\t\t  ${pdfs.pagesize} \n\n'),
                                new TextSpan(text: 'Page Count \t\t\t\t\t\t  ${pdfs.pagecount} \n\n'),
                              ],
                            ),
                          ),
                          new Image.network(
                            '${pdfs.pdfimage}',
                            fit: BoxFit.cover,
                          ),
                          new RaisedButton(
                            onPressed: () async{

                              var url = '${pdfs.pdfurl}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            color: Colors.blue,
                            child: new Text('Download',style: TextStyle(color: Colors.white),),
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
