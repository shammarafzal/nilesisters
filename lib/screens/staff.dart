import 'package:nilesisters/Model/getStaff.dart';
import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';

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
              FutureBuilder<GetStaff>(
                future: Utils().fetchstaff(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(itemCount: snapshot.data.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index ){
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
                                        Align(alignment: Alignment.topLeft,child: Text(snapshot.data.data[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                        Align(alignment: Alignment.topLeft,child: Text(snapshot.data.data[index].designation,style: TextStyle(fontSize: 20),))
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            child: Image.network(
                              Utils().image_base_url+'${snapshot.data.data[index].image}',
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
