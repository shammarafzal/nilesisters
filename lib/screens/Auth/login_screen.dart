import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  await EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  var response = await Utils()
                      .login(_email.text, _password.text);
                  if (response['status'] == false) {
                    _timer?.cancel();
                    await EasyLoading.showError(
                        response['message']);
                  } else {
                    prefs.setBool('isLoggedIn', true);
                    prefs.setString('token', response['token']);
                    prefs.setInt('id', response['user']['id']);
                    _timer?.cancel();
                    await EasyLoading.showSuccess(
                        response['message']);
                    Navigator.of(context)
                        .pushReplacementNamed('/home_page');
                  }
                },
                child: Text(
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
                Navigator.of(context).pushNamed('forgot_password');
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
             GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/signup');
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
    );
  }
}
