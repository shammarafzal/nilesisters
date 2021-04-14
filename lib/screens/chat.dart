import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:nilesisters/API_Data/users.dart';
import 'fetchposts.dart';
class Chat_Screen extends StatefulWidget {
  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}
class _Chat_ScreenState extends State<Chat_Screen> {
  Users user;
  String id;
  String name;
  getUsers() async {
    var url =
    Uri.https('nilesisters.codingoverflow.com', '/api/getusers.php', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": 'a',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      List<dynamic> list = json.decode(responseString);
      user = Users.fromJson(list[0]);
      id = user.id;
      name = user.name;
      return user.id;
    } else {
      return null;
    }
  }
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
  final messageTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }
  String messageText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: TextField(
                                    controller: messageTextController,
                                    onChanged: (value) {
                                      messageText = value;
                                    },
                                  ),
                                  ),
                                  FlatButton(onPressed: () async {
                                    DateTime now = DateTime.now();
                                    var url = Uri.http(
                                        'localhost:8888',
                                        '/public_html/addpost.php',
                                        {"q": "dart"});
                                    final response = await http.post(url, body: {
                                      "userid": id,
                                      "posttext": messageText,
                                      "datetime": now.toString()
                                    });
                                    if (response.statusCode == 200) {
                                      final String responseString = response.body;
                                    }
                                  },
                                      child: Text(
                                          'Send',
                                          style: TextStyle(color: Colors.blue)
                                      ),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                );
              }
          ),
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
          ]
      ),
    );
  }
}