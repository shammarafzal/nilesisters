import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nilesisters/API_Data/getcomments.dart';
import 'package:nilesisters/API_Data/getpost.dart';
import 'package:http/http.dart' as http;
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/showcomments.dart';
import 'dart:convert';
import 'fetchposts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ShowPosts extends StatefulWidget {
  final userID;

  ShowPosts({
   this.userID,
});
  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  final _formKey = GlobalKey<FormState>();
  GetPosts getpost;
  bool isLoading = false;
  final messageTextController = TextEditingController();
  String messageText;
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
  getComment() async {


  }
  @override
  Widget build(BuildContext context) {
    getComment();
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
                              onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('postid', eventss.postid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowComments(postID: eventss.postid),
                                    ));
                              },
                            ),
                          ),
                          trailing: TextButton(
                            child: Text('Add Comments',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Positioned(
                                              right: -40.0,
                                              top: -40.0,
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.close),
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          hintText: DemoLocalization.of(context)
                                                              .getTranslatedValue('enter_something')

                                                      ),
                                                      controller: messageTextController,
                                                      onChanged: (value) {
                                                        messageText = value;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: RaisedButton(
                                                      child: Text("Submit"),
                                                      onPressed: () async {
                                                        if (_formKey.currentState.validate()) {
                                                          _formKey.currentState.save();
                                                        }
                                                        DateTime now = DateTime.now();
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        var url = Uri.https(
                                                            'nilesisters.codingoverflow.com',
                                                            '/api/addcomments.php',
                                                            {"q": "dart"});
                                                        final response = await http.post(url,
                                                            body: {
                                                              "userid": widget.userID,
                                                              "postid": eventss.postid,
                                                              "comment": messageText,
                                                              "datetime": now.toString()
                                                            });
                                                        if (response.statusCode == 200) {
                                                          final String responseString =
                                                              response.body;

                                                          if (responseString == 'Comment Added'){
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            Fluttertoast.showToast(
                                                              msg: "Comment Added Successfull",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.CENTER,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                            messageTextController.text = '';
                                                            Navigator.of(context).pop();
                                                          }
                                                          else{
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            Fluttertoast.showToast(
                                                              msg: "Failed",
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
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              });
                            },
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
