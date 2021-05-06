import 'package:flutter/material.dart';
import 'package:nilesisters/screens/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _validateEmail = false;
  bool  _validatePassword = false;
  bool emailValid = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
          automaticallyImplyLeading: false,
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
                  controller: _email,
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                      _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                      _password.text.isEmpty ? _validatePassword = true : _validatePassword = false;

                    });
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(emailValid == false){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Email is not Valid')));
                    }
                    if (_email.text != "" &&  _password.text != "" && emailValid != false) {
                      isLoading = true;
                      var url = Uri.https('nilesisters.codingoverflow.com',
                          '/api/login.php', {"q": "dart"});
                      final response = await http.post(url, body: {
                        "email": _email.text,
                        "password": _password.text,
                      });
                      if (response.statusCode == 200) {
                        final String responseString = response.body;
                        if (responseString == 'Login Successful') {
                          isLoading = false;
                          prefs.setBool('isLoggedIn', true);
                          Fluttertoast.showToast(
                            msg: "Login Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  text: _email.text,
                                ),
                              ));
                        } else {
                          setState(() {
                            isLoading = false;
                          });

                          Fluttertoast.showToast(
                            msg: "Login Failed",
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
                      : Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'forgotPassword');
                },
                child: new RichText(
                  text: TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children:[
                        TextSpan(text: 'Forgot Password',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'signup_screen');
                },
                child: new RichText(
                  text: TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children:[
                        TextSpan(text: 'Do not have an account? '),
                        TextSpan(text: 'Register',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
