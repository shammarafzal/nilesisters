import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getPosts.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/showcomments.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/viewFullMessage.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'chat.dart';

class ShowPosts extends StatefulWidget {
  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  final _formKey = GlobalKey<FormState>();
  Timer _timer;
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: FutureBuilder<GetPosts>(
        future: Utils().fetchposts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.data.length,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ViewFullMessage(user_name: snapshot.data.data[index].user.name, post_date: snapshot.data.data[index].createdAt.toString(), post_text: snapshot.data.data[index].post,),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
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
                              snapshot.data.data[index].user.name,
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
                            trailing: Container(
                              width: SizeConfig.screenWidth * 0.5,
                              child: Text(
                                snapshot.data.data[index].post,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                // softWrap: false,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Container(
                              child: TextButton(
                                child: Text(
                                DemoLocalization.of(context)
                                    .getTranslatedValue('view_comments'),
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
                                DemoLocalization.of(context)
                                    .getTranslatedValue('add_comments'),
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
                                            // overflow: Overflow.visible,
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
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                            MaterialStateProperty.all(Colors.blue)),
                                                        child: Text(DemoLocalization
                                                            .of(context)
                                                            .getTranslatedValue(
                                                            'send'), style: TextStyle(color: Colors.white)),
                                                        onPressed: () async {
                                                            try {
                                                              await EasyLoading.show(
                                                                status: 'loading...',
                                                                maskType: EasyLoadingMaskType.black,
                                                              );
                                                              var response = await Utils().sendComment(
                                                                  messageTextController.text, snapshot.data.data[index].id.toString()
                                                              );

                                                              if (response['status'] == false) {
                                                                _timer?.cancel();
                                                                await EasyLoading.showError(
                                                                    response['message']);
                                                              } else {
                                                                _timer?.cancel();
                                                                await EasyLoading.showSuccess(
                                                                    response['message']);
                                                                Navigator.of(context).pop();
                                                              }
                                                            }
                                                            catch(e){
                                                              _timer?.cancel();
                                                              await EasyLoading.showError(
                                                                  'Something Went Wrong');
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
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new Chat_Screen(),
            ),
          );
        },
        child: const Icon(Icons.messenger_outlined),
        backgroundColor: Colors.red,
      ),
    );
  }
}
