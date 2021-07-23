import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';

import '../AlertDialog/alertDialog.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  bool isLoading = false;

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
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(_email.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Email");
                    }
                    else if(emailValid == false){
                      alertScreen().showAlertDialog(context, "Please Enter Valid Email");
                    }
                    else{
                      isLoading = true;
                      var response = await Utils().forgot(_email.text);
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
                        await alertScreen().showForgotAlertDialog(context, "Please check your email!!!");
                      }
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
