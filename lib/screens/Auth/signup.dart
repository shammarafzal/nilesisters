import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  final _phone = TextEditingController();
  Timer _timer;
  File imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
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
            // SizedBox(height: 15.0),
            // IconButton(
            //     onPressed: () async {
            //       final picker = ImagePicker();
            //       var image =
            //       await picker.getImage(source: ImageSource.gallery);
            //       if (image != null) {
            //         imagePath = File(image.path);
            //       }
            //     },
            //     icon: Icon(Icons.arrow_circle_up)),
            SizedBox(
              height: 15.0,
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
                controller: _confirmpassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                controller: _phone,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  hintText: 'Enter Phone',
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
                  try {
                    await EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    var response = await Utils().register(
                        _name.text,
                        _email.text,
                        _password.text,
                        _confirmpassword.text,
                        _phone.text,
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
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            ),
            //Text('Already have an account? Login')
          ],
        ),
      ),
    );
  }
}
