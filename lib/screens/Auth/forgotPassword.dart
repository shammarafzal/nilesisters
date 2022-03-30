import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  await EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  var response = await Utils()
                      .forgot(_email.text);
                  if (response['status'] == false) {
                    _timer?.cancel();
                    await EasyLoading.showError(
                        response['message']);
                  } else {
                    _timer?.cancel();
                    await EasyLoading.showSuccess(
                        response['message']);
                    Navigator.of(context)
                        .pushReplacementNamed('/verify_token');
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
