

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool  _validatePassword = false;
  bool emailValid = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Register"),
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
                    errorText: _validateName ? 'Name Can\'t Be Empty' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  //  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com',
                    errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                        errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,
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
                    setState(() {
                      _name.text.isEmpty ? _validateName = true : _validateName = false;
                      _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                      _password.text.isEmpty ? _validatePassword = true : _validatePassword = false;

                    });
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(emailValid == false){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Email is not Valid')));
                    }
                    if(_email.text != "" && _name.text != "" && _password.text != ""  && emailValid != false) {
                      final String Rpic = "aaa";
                      var url = Uri.https('nilesisters.codingoverflow.com',
                          '/api/userregistration.php', {"q": "dart"});
                      final response = await http.post(url, body: {
                        "email": _email.text,
                        "password": _password.text,
                        "image": Rpic,
                        "name": _name.text,
                      });
                      if (response.statusCode == 200) {
                        final String responseString = response.body;
                        if (responseString == 'Register Successfull') {
                          Fluttertoast.showToast(
                            msg: "Register Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          await Navigator.pushNamed(context, 'loginroute');
                        }
                        if (responseString == 'Already Registered') {
                          Fluttertoast.showToast(
                            msg: "Email Already Exist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        else {
                          Fluttertoast.showToast(
                            msg: "Error",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
                      else {
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
                    }
                    else{
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
                  child:  Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'loginroute');
                },
                child: new RichText(
                  text: TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children:[
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(text: 'Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
              //Text('Already have an account? Login')
            ],
          ),
        ),
      ),
    );
  }
}
