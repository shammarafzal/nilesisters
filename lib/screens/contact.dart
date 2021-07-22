import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'alertDialog.dart';
class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}
class _ContactState extends State<Contact> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool emailValid = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Contact Us"),
          
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/nilesisters.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  //  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  maxLines: 5,
                  controller: _message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Message',
                    hintText: 'Enter Message Here',
                  ),
                ),
              ),

              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(_name.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Name");
                    }
                    else if(_email.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Email");
                    }
                    else if(emailValid == false){
                      alertScreen().showAlertDialog(context, "Please Enter Valid Email");
                    }
                    else if(_message.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Message");
                    }

                    else{
                      isLoading = true;
                      var response = await Utils().contact(_name.text, _email.text, _message.text);
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
                    child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                  )
                      :Text(
                    'Send Message',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
