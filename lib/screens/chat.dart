import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/API_Data/users.dart';
import 'package:nilesisters/screens/showuserposts.dart';

class Chat_Screen extends StatefulWidget {
  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  Users user;
  String id;
  String name;

  getUsers() async {
    var url = Uri.https(
        'nilesisters.codingoverflow.com', '/api/getusers.php', {"q": "dart"});
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
      body: ListView(children: [
        Container(height: 40,),
        Text("Send Post",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.blue),),
        FutureBuilder(
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
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter something to Post'

                                    ),
                                    controller: messageTextController,
                                    onChanged: (value) {
                                      messageText = value;
                                    },
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    DateTime now = DateTime.now();
                                    var url = Uri.https(
                                        'nilesisters.codingoverflow.com',
                                        '/api/addpost.php',
                                        {"q": "dart"});
                                    final response = await http.post(url,
                                        body: {
                                          "userid": id,
                                          "posttext": messageText,
                                          "datetime": now.toString()
                                        });
                                    if (response.statusCode == 200) {
                                      final String responseString =
                                          response.body;

                                      if (responseString == 'Posted'){
                                        Fluttertoast.showToast(
                                          msg: "Posted Successfull",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        messageTextController.text = '';
                                      }
                                      else{
                                        Fluttertoast.showToast(
                                          msg: "Post Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }

                                    }
                                  },
                                  child: Text('Send',
                                      style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
              // style: TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.blue),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
        Container(
          decoration: BoxDecoration(
            // color: const Color(0xff7c94b6),
            border: Border.all(
               color: Colors.white,
              width: 8,
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowPosts(),
                  ));
            },
            child: Text('Show Posts'),
            style: TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.blue),
          ),
        )
      ]),
    );
  }
}
