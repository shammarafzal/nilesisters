import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  bool _validateEmail = false;
  bool emailValid = false;
  String username = 'bhad.biz@gmail.com';
  String password = '28ua3438G!';

  bool isLoading = false;
  sendMail(String email, String Msg) async {
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Nilesisters')
      ..recipients.add(email)
      ..subject = ' Password Reset'
      ..text = 'Hello, \n We\'ve received forgot password request for the <b>NileSisters</b>c'
      ..html = "<h1>Hello</h1>\n<p>We\'ve received forgot password request for the <b>NileSisters</b>  \n account assosiated with $email. No changes \n have been made to your account yet. \nHere is your password  <b>$Msg</b></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Forgot Password"),
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
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                    errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
                  ),
                ),
              ),

              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    setState(() {
                      _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;

                    });
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(emailValid == false){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Email is not Valid')));
                    }
                    if (_email.text != "" && emailValid != false) {
                      isLoading = true;
                      var url =  Uri.https('nilesisters.codingoverflow.com', '/api/getusers.php', {"q": "dart"});
                      final response = await http.post(url, body: {
                        "email": _email.text,
                      });
                      if (response.statusCode == 200) {
                        final String responseString = response.body;
                        List<dynamic> list = json.decode(responseString);

                        isLoading = false;
                          Fluttertoast.showToast(
                            msg: "Check Your Email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                         // sendMail( _email.text,user.password);
                          Navigator.pushNamed(context, 'loginroute');
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: "API Response Error",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      Fluttertoast.showToast(
                        msg: "Check Input Data",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: isLoading
                      ? Center(
                    child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                  )
                      :Text(
                    'Forgot Password',
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
