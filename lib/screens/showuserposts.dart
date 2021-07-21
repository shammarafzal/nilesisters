import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getPosts.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/showcomments.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'alertDialog.dart';

class ShowPosts extends StatefulWidget {
  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niesisters'),
      ),
      body: FutureBuilder<GetPosts>(
        future: Utils().fetchposts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue('from'),
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            snapshot.data.user.name,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue('message'),
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            snapshot.data.data[index].post,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Container(
                            child: TextButton(
                              child: Text(
                                'View Comments',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShowComments(postID: snapshot.data.data[index].id),
                                    ));
                              },
                            ),
                          ),
                          trailing: TextButton(
                            child: Text(
                              'Add Comments',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText: DemoLocalization
                                                                  .of(context)
                                                              .getTranslatedValue(
                                                                  'enter_something')),
                                                      controller:
                                                          messageTextController,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: RaisedButton(
                                                      child: Text("Submit"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey.currentState
                                                              .save();
                                                        }
                                                        if(messageTextController.text == ""){
                                                          alertScreen().showAlertDialog(context, "Please Enter Comment Text");
                                                        }
                                                        else{
                                                          isLoading = true;
                                                          var response = await Utils().sendComment(messageTextController.text, snapshot.data.data[index].id.toString());
                                                          if(response['status'] == false){
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            alertScreen().showAlertDialog(context, response['message']);
                                                          }
                                                          else{
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            await alertScreen().showAlertDialog(context, response['message']);
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
