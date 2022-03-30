import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Password"),
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
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                controller: _confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
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

                  try {
                    await EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    var response = await Utils().resetPassword(
                        _password.text,
                        _confirmPassword.text,
                        arguments['token']
                    );

                    if (response['status'] == false) {
                      _timer?.cancel();
                      await EasyLoading.showError(
                          response['message']);
                    } else {
                      _timer?.cancel();
                      await EasyLoading.showSuccess(
                          response['message']);
                      Navigator.of(context).pushReplacementNamed('/login');
                    }
                  }
                  catch(e){
                    _timer?.cancel();
                    await EasyLoading.showError(
                        'Something Went Wrong');
                  }
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
