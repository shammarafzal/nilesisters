import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/getcomments.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/localization/demo_localization.dart';
import 'dart:convert';
import 'fetchposts.dart';
class ShowComments extends StatefulWidget {
  final postID;
  ShowComments({
    this.postID,
  });
  @override
  _ShowCommentsState createState() => _ShowCommentsState();
}

class _ShowCommentsState extends State<ShowComments> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niesisters'),
      ),
      body: FutureBuilder(
        future: fetchComments(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index ){
                GetComments eventss = snapshot.data[index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('from'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                          trailing: Text('${eventss.username}',style: TextStyle(fontSize: 20),),
                        ),
                        ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('message'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                          trailing: Text('${eventss.comenttext}',style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child:  Text('No Comments'),);
        },
      ),
    );
  }

}
