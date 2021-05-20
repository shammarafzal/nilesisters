import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/localization/demo_localization.dart';
import 'dart:convert';
import 'fetchposts.dart';
class ShowPosts extends StatefulWidget {
  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  GetPosts getpost;
  String msg;
  getPosts() async {
    var url =
    Uri.https('nilesisters.codingoverflow.com', '/api/getposts.php', {"q": "dart"});
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return json.decode(responseString);
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niesisters'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index ){
                GetPosts eventss = snapshot.data[index];
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
                          trailing: Text('${eventss.posttext}',style: TextStyle(fontSize: 20),),
                        ),
                        ListTile(
                          title: Container(
                            child: TextButton(
                              child: Text('View Comments',style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                              onPressed: () {},
                            ),
                          ),
                          trailing: TextButton(
                            child: Text('Add Comments',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {},
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
    );
  }
}
