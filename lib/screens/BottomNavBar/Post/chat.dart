import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/showuserposts.dart';
import 'package:nilesisters/utils/Utils.dart';

import '../../AlertDialog/alertDialog.dart';

class Chat_Screen extends StatefulWidget {
  @override
  _Chat_ScreenState createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  bool isLoading = false;
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 40,
          ),
          Text(
            DemoLocalization.of(context).getTranslatedValue('send_post'),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.blue),
          ),
          Padding(
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
                              hintText: DemoLocalization.of(context)
                                  .getTranslatedValue('enter_something')),
                          controller: messageTextController,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if(messageTextController.text == ""){
                            alertScreen().showAlertDialog(context, "Please Enter Post Text");
                          }
                          else{
                            isLoading = true;
                            var response = await Utils().sendPost(messageTextController.text);
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
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              )
                            : Text(
                                DemoLocalization.of(context)
                                    .getTranslatedValue('send'),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 8,
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(DemoLocalization.of(context)
                  .getTranslatedValue('show_posts')),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
