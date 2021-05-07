import 'package:nilesisters/API_Data/pdf.dart';
import 'package:nilesisters/API_Data/staff.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/screens/staffApi.dart';
import 'package:url_launcher/url_launcher.dart';
class StaffViewer extends StatefulWidget {
  @override
  _StaffViewerState createState() => _StaffViewerState();
}
class _StaffViewerState extends State<StaffViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Staff'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Our Staff',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              ),
              FutureBuilder(
                future: fetchStaff(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index ){
                        Staff staff = snapshot.data[index];
                        return Card(
                          elevation: 5,
                          child: GridTile(
                            footer: Container(
                              color: Colors.white70,
                              child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10,0,0,5),
                                    child: Column(
                                      children: [
                                        Align(alignment: Alignment.topLeft,child: Text(staff.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                        Align(alignment: Alignment.topLeft,child: Text(staff.designation,style: TextStyle(fontSize: 20),))
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            child: Image.network(
                              staff.staffimf,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
