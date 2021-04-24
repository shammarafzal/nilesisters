import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
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
      body: ListView(
        children: [

          FutureBuilder(
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
                            new RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(text: 'From \t\t\t\t\t\t  ${eventss.username} \n\n'),
                                  new TextSpan(text: 'Message \t\t\t\t\t\t  ${eventss.posttext} \n\n'),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
