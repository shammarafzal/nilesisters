import 'package:flutter/material.dart';
import 'package:nilesisters/utils/Utils.dart';

import '../AlertDialog/alertDialog.dart';
class NewPassword extends StatefulWidget {
  final token;
  NewPassword({this.token});
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
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
                    if(_password.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Password");
                    }
                    else if(_password.text.length <= 7 ){
                      alertScreen().showAlertDialog(context, "Password Length Must Greater than 8");
                    }
                    else if(_confirmPassword.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Confirm Password");
                    }
                    else if(_confirmPassword.text.length <= 7 ){
                      alertScreen().showAlertDialog(context, "Confirm Password Length Must Greater than 8");
                    }
                    else if(_password.text != _confirmPassword.text){
                      alertScreen().showAlertDialog(context, "Password Doesn't Match");
                    }
                    else{
                      isLoading = true;
                      var response = await Utils().resetPassword(widget.token, _password.text, _confirmPassword.text);
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
                        alertScreen().showSignupAlertDialog(context, response['message']);
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
