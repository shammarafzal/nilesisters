import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alertDialog.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _email = TextEditingController();
  final _password = TextEditingController();
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
                    final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_email.text);
                    if (_email.text == "") {
                      alertScreen()
                          .showAlertDialog(context, "Please Enter Email");
                    } else if (emailValid == false) {
                      alertScreen().showAlertDialog(
                          context, "Please Enter Valid Email");
                    } else if (_password.text == "") {
                      alertScreen().showAlertDialog(
                          context, "Please Enter Password");
                    } else if (_password.text.length <= 7) {
                      alertScreen().showAlertDialog(
                          context, "Please Length Must Greater than 8");
                    } else {
                      isLoading = true;
                      var response = await Utils().login(_email.text, _password.text);
                      if(response['status'] == false ){
                        setState(() {
                          isLoading = false;
                        });
                        alertScreen().showAlertDialog(context, response['message']);
                      }
                      else{
                        setState(() {
                          isLoading = false;
                        });
                        prefs.setBool('isLoggedIn', true);
                        prefs.setString('token', response['token']);
                        prefs.setInt('id', response['user']['id']);
                        await alertScreen().showSigninAlertDialog(context, "Login Successfully");
                      }
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
