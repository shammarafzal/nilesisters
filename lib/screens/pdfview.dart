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
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: Text('${pdfs.title}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),),),
                          ListTile(
                            title: Text('Title',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${pdfs.title}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text('Edition',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${pdfs.edition}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text('Contect',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text('${pdfs.contect}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text('Format',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${pdfs.format}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text('Page Size',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${pdfs.pagesize}',style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text('Page Count',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(' ${pdfs.pagecount}',style: TextStyle(fontSize: 20),),
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
